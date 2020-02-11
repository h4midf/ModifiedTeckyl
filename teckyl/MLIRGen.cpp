#include "MLIRGen.h"

#include <llvm/ADT/ScopedHashTable.h>
#include <mlir/Dialect/AffineOps/AffineOps.h>
#include <mlir/Dialect/StandardOps/Ops.h>
#include <mlir/IR/AffineExpr.h>
#include <mlir/IR/Builders.h>
#include <mlir/IR/Function.h>
#include <mlir/IR/StandardTypes.h>

#include <tc/lang/sema.h>

#include <map>
#include <set>

namespace teckyl {

using IteratorBoundsMap =
    std::map<std::string, std::pair<mlir::Value, mlir::Value>>;
using IteratorRangeMap = std::map<std::string, lang::RangeConstraint>;

static const char *getTypeAsString(mlir::Type t) {
  if (t.isF16())
    return "f16";
  else if (t.isF32())
    return "f32";
  else if (t.isF64())
    return "f64";
  else if (t.isInteger(8))
    return "i8";
  else if (t.isInteger(16))
    return "i16";
  else if (t.isInteger(32))
    return "i32";
  else if (t.isInteger(64))
    return "i64";
  else if (t.isIndex())
    return "index";

  throw mlirgen::Exception("Cannot determine name for type");
}

static bool inline isSignedIntType(int kind) {
  switch (kind) {
  case lang::TK_INT8:
  case lang::TK_INT16:
  case lang::TK_INT32:
  case lang::TK_INT64:
    return true;

  default:
    return false;
  }
}

static inline bool isUnsignedIntType(int kind) {
  switch (kind) {
  case lang::TK_UINT8:
  case lang::TK_UINT16:
  case lang::TK_UINT32:
  case lang::TK_UINT64:
    return true;

  default:
    return false;
  }
}

static inline bool isIntType(int kind) {
  return isSignedIntType(kind) || isUnsignedIntType(kind);
}

static unsigned getIntBits(int kind) {
  switch (kind) {
  case lang::TK_INT8:
  case lang::TK_UINT8:
    return 8;
  case lang::TK_INT16:
  case lang::TK_UINT16:
    return 16;
  case lang::TK_INT32:
  case lang::TK_UINT32:
    return 32;
  case lang::TK_INT64:
  case lang::TK_UINT64:
    return 64;

  default:
    throw mlirgen::Exception("Unexpected kind");
  }
}

static inline bool isFloatType(int kind) {
  switch (kind) {
  case lang::TK_FLOAT:
  case lang::TK_FLOAT16:
  case lang::TK_FLOAT32:
  case lang::TK_FLOAT64:
    return true;

  default:
    return false;
  }
}

// Resursively maps the function `fn` to `tree` and all of its
// descendants in preorder.
static void mapRecursive(const lang::TreeRef &tree,
                         std::function<void(const lang::TreeRef &)> fn) {
  fn(tree);

  for (auto e : tree->trees())
    mapRecursive(e, fn);
}

// Collects the set of iterators of a comprehensions by listing all
// identifiers and retaining only those that are not in the symbol
// table `symTab`.
static std::set<std::string> collectIterators(
    const lang::Comprehension &comprehension,
    const llvm::ScopedHashTable<llvm::StringRef, mlir::Value> &symTab) {
  std::set<std::string> iterators;

  mapRecursive(comprehension, [&](const lang::TreeRef &t) {
    if (t->kind() == lang::TK_IDENT) {
      std::string name = lang::Ident(t).name();

      if (symTab.count(name) == 0)
        iterators.insert(name);
    }
  });

  return iterators;
}

// Collects all range constraints specified in `where` clauses of the
// comprehension c
static IteratorRangeMap
collectExplicitIteratorBounds(const lang::Comprehension &c) {
  IteratorRangeMap bounds;

  for (auto where : c.whereClauses()) {
    if (where->kind() != lang::TK_RANGE_CONSTRAINT)
      continue;

    auto range = lang::RangeConstraint(where);
    std::string name = range.ident().name();

    bounds.insert({name, range});
  }

  return std::move(bounds);
}

// Collects the set of parameters from the signature of `def` that
// define the sizes of dimensions. for example, for the signature
//
//   def foo(float(M, N) A, float(K) x)
//
// The function would return a set composed of M, N and K.
static std::set<std::string> collectDimSizeParams(const lang::Def &def) {
  std::set<std::string> sizeParams;

  for (const lang::Param &param : def.params()) {
    for (const lang::TreeRef &dim : param.tensorType().dims()) {
      if (dim->kind() == lang::TK_IDENT) {
        lang::Ident ident(dim);

        sizeParams.insert(ident.name());
      }
    }
  }

  return sizeParams;
}

class MLIRGenImpl {
public:
  MLIRGenImpl(mlir::MLIRContext &context,
              const std::string &filename = "unknown file")
      : builder(&context), filename(filename) {}

  // Builds a FuncOp for a definition `def`
  mlir::FuncOp buildFunction(const std::string &name, const lang::Def &def) {
    llvm::ScopedHashTableScope<llvm::StringRef, mlir::Value> var_scope(symTab);
    std::vector<mlir::Type> argTypes;

    // Add parameters for symbolic tensor dimensions
    std::set<std::string> sizeParams = collectDimSizeParams(def);

    for (size_t i = 0; i < sizeParams.size(); i++)
      argTypes.push_back(builder.getIndexType());

    // Add tensor parameters
    for (lang::Param param : def.params()) {
      lang::TensorType tensorType = param.tensorType();
      mlir::Type mlirTensorType = getTensorType(tensorType);
      argTypes.push_back(mlirTensorType);
    }

    // Add output parameters
    std::map<std::string, size_t> outputRanks = collectOutputRanks(def);

    for (lang::Param param : def.returns()) {
      lang::TensorType tcTensorType = param.tensorType();
      std::string name = param.ident().name();

      if (param.typeIsInferred()) {
        std::stringstream ss;

        ss << "Type for output tensor " << name << " not specified";

        throw mlirgen::SourceException(loc(param.range()), ss.str());
      }

      // Check that used dimensions correspond to the declared
      // dimensions
      if (outputRanks.find(name) != outputRanks.end()) {
        size_t declaredDims = tcTensorType.dims().size();

        if (declaredDims != outputRanks[name]) {
          std::stringstream ss;

          ss << "Output tensor " << name << " has been declared with "
             << declaredDims << " dimensions, "
             << "but is indexed with " << outputRanks[name] << " "
             << "dimensions";

          throw mlirgen::Exception(ss.str());
        }
      }

      mlir::Type mlirTensorType =
          mlir::MemRefType::get(std::vector<int64_t>(outputRanks[name], -1),
                                getScalarType(tcTensorType.scalarType()));

      argTypes.push_back(mlirTensorType);
    }

    mlir::FunctionType func_type =
        builder.getFunctionType(argTypes, llvm::None);

    mlir::FuncOp funcOp =
        mlir::FuncOp::create(loc(def.range()), name, func_type);

    mlir::FuncOp function(funcOp);
    mlir::Block &entryBlock = *function.addEntryBlock();

    // Add all arguments to symbol table
    {
      size_t i = 0;

      // Add parameters for symbolic tensor dimensions to symbol table
      for (const std::string &sizeParam : sizeParams)
        symTab.insert(sizeParam, funcOp.getArgument(i++));

      // Add input tensors
      for (lang::Param param : def.params()) {
        mlir::BlockArgument arg = funcOp.getArgument(i++);
        symTab.insert(param.ident().name(), arg);
      }

      // Add outputs
      for (lang::Param param : def.returns()) {
        mlir::BlockArgument arg = funcOp.getArgument(i++);
        symTab.insert(param.ident().name(), arg);
      }
    }

    builder.setInsertionPointToStart(&entryBlock);

    for (const lang::Comprehension &comprehension : def.statements())
      buildComprehension(comprehension);

    builder.create<mlir::ReturnOp>(loc(def.range()));

    return function;
  }

private:
  mlir::OpBuilder builder;
  llvm::ScopedHashTable<llvm::StringRef, mlir::Value> symTab;
  std::string filename;

  // Translates a TC source location to an MLIR source location
  mlir::FileLineColLoc loc(const lang::SourceRange &r) {
    return builder
        .getFileLineColLoc(builder.getIdentifier(filename), r.startLine(),
                           r.endLine())
        .cast<mlir::FileLineColLoc>();
  }

  // Returns the element type of `v` if `v` is a MemRef value,
  // otherwise the function returns the type of `v`.
  mlir::Type getElementType(const mlir::Value &v) {
    mlir::Type type = v.getType();

    if (type.isa<mlir::MemRefType>())
      return type.cast<mlir::MemRefType>().getElementType();
    else
      return type;
  }

  // Translates a TC float type to an MLIR float type
  mlir::FloatType getFloatType(int kind) {
    switch (kind) {
    case lang::TK_FLOAT:
      return builder.getF32Type();
    case lang::TK_FLOAT16:
      return builder.getF16Type();
    case lang::TK_FLOAT32:
      return builder.getF32Type();
    case lang::TK_FLOAT64:
      return builder.getF64Type();
    default:
      throw mlirgen::Exception("Not a float type");
    }
  }

  mlir::Type getScalarType(int kind) {
    switch (kind) {
    case lang::TK_FLOAT:
    case lang::TK_FLOAT16:
    case lang::TK_FLOAT32:
    case lang::TK_FLOAT64:
      return getFloatType(kind);
    case lang::TK_INT8:
      return builder.getIntegerType(8);
    case lang::TK_INT16:
      return builder.getIntegerType(16);
    case lang::TK_INT32:
      return builder.getIntegerType(32);
    case lang::TK_INT64:
      return builder.getIntegerType(64);
    default:
      throw mlirgen::Exception("Unsupported type");
    }
  }

  // Translates a TC tensor type into an MLIR tensor type. If the
  // original type is a scalar type, a scalar MLIR type is returned.
  mlir::Type getTensorType(const lang::TensorType &tensorType) {
    mlir::Type scalarType = getScalarType(tensorType.scalarType());
    size_t ndims = tensorType.dims().size();

    if (ndims > 0) {
      // Build a MemRef type with the correct number of dimensions,
      // but leave size of dimensions undefined return
      return mlir::MemRefType::get(std::vector<int64_t>(ndims, -1), scalarType);
    } else {
      return scalarType;
    }
  }

  // Builds a binary MLIR expression from a TC expression
  template <typename OpTy>
  OpTy buildBinaryExpr(const lang::TreeRef &t) {
    mlir::Value vals[2] = {buildExpr(t->trees().at(0)),
                           buildExpr(t->trees().at(1))};

    if (vals[0].getType() != vals[1].getType()) {
      std::stringstream ss;

      ss << "Operands for "
         << "'" << (char)t->kind() << "' "
         << "have different types: " << getTypeAsString(vals[0].getType())
         << " and " << getTypeAsString(vals[1].getType());

      throw mlirgen::SourceException(loc(t->range()), ss.str());
    }

    return builder.create<OpTy>(loc(t->range()), vals[0], vals[1]);
  }

  // Builds an MLIR constant from a TC constant. The type of the
  // constant is preserved.
  //
  // Throws an exception if the TC type cannot be expressed in MLIR.
  mlir::Value buildConstant(const lang::Const &cst) {
    int kind = cst.type()->kind();
    mlir::FileLineColLoc location(loc(cst.range()));

    if (isIntType(kind)) {
      unsigned num_bits = getIntBits(kind);

      if (isSignedIntType(kind)) {
        return builder.create<mlir::ConstantIntOp>(
            location, (int64_t)cst.value(), num_bits);
      } else {
        throw mlirgen::SourceException(location,
                                       "Unsigned integers are not supported");
      }
    } else if (isFloatType(kind)) {
      mlir::FloatType floatType = getFloatType(kind);

      return builder.create<mlir::ConstantFloatOp>(
          location, llvm::APFloat(cst.value()), floatType);
    } else {
      throw mlirgen::SourceException(location, "Unsupported constant type");
    }
  }

  // Builds a MLIR value corresponding to the TC identifier `i`.
  mlir::Value buildIdent(const lang::Ident &i) {
    return symTab.lookup(i.name());
  }

  // Builds an MLIR load operation indexing the tensor that
  // corresponds to `ident` using the symbols corresponding to the
  // identifiers from `indices`.
  mlir::LoadOp buildIndexLoadExpr(const lang::Ident &ident,
                                  const lang::ListView<lang::Ident> &indices) {
    std::vector<mlir::Value> argVals;

    for (const lang::Ident &arg : indices) {
      auto subexpr = buildIdent(arg);
      argVals.push_back(subexpr);
    }

    mlir::Value tensor = symTab.lookup(ident.name());

    return builder.create<mlir::LoadOp>(loc(ident.range()), tensor, argVals);
  }

  // Builds an MLIR load operation indexing the tensor that
  // corresponds to `ident` using the expressions passed in `indices`.
  mlir::LoadOp
  buildIndexLoadExpr(const lang::Ident &ident,
                     const lang::ListView<lang::TreeRef> &indices) {
    std::vector<mlir::Value> argVals;

    for (const lang::TreeRef &arg : indices) {
      auto subexpr = buildExpr(arg);
      argVals.push_back(subexpr);
    }

    mlir::Value tensor = symTab.lookup(ident.name());

    return builder.create<mlir::LoadOp>(loc(ident.range()), tensor, argVals);
  }

  // Translates a TC apply expression into an MLIR load operation.
  mlir::LoadOp buildIndexLoadExpr(const lang::Apply &a) {
    return buildIndexLoadExpr(a.name(), a.arguments());
  }

  // Builds an MLIR store operation writing the value `valueToStore`
  // to the tensor corresponds to `ident` indexed using the symbols
  // corresponding to the identifiers from `indices`.
  mlir::StoreOp
  buildIndexStoreExpr(mlir::Value &valueToStore, const lang::Ident &ident,
                      const lang::ListView<lang::Ident> &indices) {
    mlir::FileLineColLoc location(loc(ident.range()));
    mlir::Value tensor = symTab.lookup(ident.name());

    std::vector<mlir::Value> argVals;

    for (const lang::Ident &idx : indices) {
      auto subexpr = buildIdent(idx);
      argVals.push_back(subexpr);
    }

    mlir::StoreOp ret =
        builder.create<mlir::StoreOp>(location, valueToStore, tensor, argVals);

    mlir::Type elementType = ret.getMemRefType().getElementType();

    if (elementType != valueToStore.getType()) {
      std::stringstream ss;

      ss << "Assignment of a value of type "
         << getTypeAsString(valueToStore.getType())
         << " to a RHS value of type " << getTypeAsString(elementType);

      throw mlirgen::SourceException(location, ss.str());
    }

    return ret;
  }

  // Translates a TC expression into an MLIR expression
  mlir::Value buildExpr(const lang::TreeRef &t) {
    switch (t->kind()) {
    case '+':
      return buildBinaryExpr<mlir::AddIOp>(t);
    case '-':
      return buildBinaryExpr<mlir::SubIOp>(t);
    case '*':
      return buildBinaryExpr<mlir::MulIOp>(t);
    case '/':
      return buildBinaryExpr<mlir::SignedDivIOp>(t);
    case lang::TK_NUMBER:
    case lang::TK_CONST:
      return buildConstant(lang::Const(t));
    case lang::TK_IDENT:
      return buildIdent(lang::Ident(t));
    case lang::TK_APPLY:
      return buildIndexLoadExpr(lang::Apply(t));
    default:
      std::stringstream ss;
      ss << "Unknown tree type: '" << (int)t->kind() << "'";
      std::cerr << ss.str() << std::endl;
      throw mlirgen::Exception(ss.str());
    }
  }

  // Builds an affine loop nest with one loop per iterator from
  // `iterators` using the bounds from `mlirIteratorBounds`.
  //
  // If `innermost` is non-NULL, a reference to the innermost loop is
  // stored in `*innermost`.
  mlir::AffineForOp
  buildAffineLoopNest(const std::vector<std::string> &iterators,
                      const IteratorBoundsMap &mlirIteratorBounds,
                      const mlir::Location &location,
                      mlir::AffineForOp *innermost = nullptr) {
    mlir::AffineForOp affFor;

    // Build affine loop nest for all involved iterators
    for (const auto &it : iterators) {
      affFor = builder.create<mlir::AffineForOp>(
          location, mlir::ValueRange({mlirIteratorBounds.at(it).first}),
          mlir::AffineMap::get(
              0, 1, {mlir::getAffineSymbolExpr(0, builder.getContext())}),
          mlir::ValueRange({mlirIteratorBounds.at(it).second}),
          mlir::AffineMap::get(
              0, 1, {mlir::getAffineSymbolExpr(0, builder.getContext())}),
          1);

      // Create symbol table entry to map iterator names to induction
      // variables
      symTab.insert(it, affFor.getInductionVar());

      if (innermost)
        *innermost = affFor;

      builder.setInsertionPointToStart(affFor.getBody());
    }

    return affFor;
  }

  // Translates a map from identifiers to TC RangeContraints to a map
  // from identifiers to pairs of MLIR values for the respective
  // bounds
  IteratorBoundsMap
  translateIteratorBounds(const IteratorRangeMap &langBounds) {
    IteratorBoundsMap mlirBounds;

    for (const std::pair<std::string, lang::RangeConstraint> &langBound :
         langBounds) {
      std::string iteratorName = langBound.first;
      const lang::RangeConstraint &constraint = langBound.second;

      mlir::Value lowBound = buildExpr(constraint.start());
      mlir::Value upBound = buildExpr(constraint.end());

      mlirBounds.insert({iteratorName, {lowBound, upBound}});
    }

    return mlirBounds;
  }

  // Builds the MLIR representation of a single comprehension
  void buildComprehension(const lang::Comprehension &c) {
    mlir::Location startLoc = loc(c.range());

    // New scope for iterators
    llvm::ScopedHashTableScope<llvm::StringRef, mlir::Value> var_scope(symTab);

    std::set<std::string> iterators = collectIterators(c, symTab);
    IteratorRangeMap langItBounds = collectExplicitIteratorBounds(c);
    IteratorBoundsMap mlirItBounds = translateIteratorBounds(langItBounds);

    // Decide on an (arbitrary) order for the iterators for the loop
    // nest
    std::vector<std::string> iteratorsSeq;
    std::copy(iterators.begin(), iterators.end(),
              std::back_inserter(iteratorsSeq));

    // Generate loop nest for initialization for default-initialized
    // reductions
    if (c.assignment()->kind() == lang::TK_PLUS_EQ_B ||
        c.assignment()->kind() == lang::TK_TIMES_EQ_B) {
      mlir::AffineForOp innermostInit;
      mlir::AffineForOp outermostInit = buildAffineLoopNest(
          iteratorsSeq, mlirItBounds, startLoc, &innermostInit);

      // Set insert position to body of innermost loop
      builder.setInsertionPointToStart(innermostInit.getBody());

      // Generate constant of correct type
      unsigned int cst;

      if (c.assignment()->kind() == lang::TK_PLUS_EQ_B) {
        cst = 0;
      } else if (c.assignment()->kind() == lang::TK_TIMES_EQ_B) {
        cst = 1;
      } else {
        throw mlirgen::Exception("Unsupported Operator");
      }

      mlir::Value outTensorVal = symTab.lookup(c.ident().name());
      mlir::Type outTensorElementType = getElementType(outTensorVal);

      mlir::Value cstVal;

      if (outTensorElementType.isa<mlir::FloatType>()) {
        mlir::FloatType fType = outTensorElementType.cast<mlir::FloatType>();

        cstVal = builder.create<mlir::ConstantFloatOp>(
            startLoc, mlir::APFloat((float)cst), fType);
      } else if (outTensorElementType.isa<mlir::IntegerType>()) {
        mlir::IntegerType iType =
            outTensorElementType.cast<mlir::IntegerType>();

        cstVal = builder.create<mlir::ConstantIntOp>(startLoc, (int64_t)cst,
                                                     iType.getWidth());
      } else {
        throw mlirgen::Exception("Unsupported init type for a reduction");
      }

      buildIndexStoreExpr(cstVal, c.ident(), c.indices());

      // Restore insertion point to point after the outermost loop
      builder.setInsertionPointToEnd(outermostInit.getParentOp()->getBlock());
    }

    // Build loop nest for actual computation
    mlir::AffineForOp innermost;
    mlir::AffineForOp outermost =
        buildAffineLoopNest(iteratorsSeq, mlirItBounds, startLoc, &innermost);

    builder.setInsertionPointToStart(innermost.getBody());

    // Build expression for RHS of assignment
    mlir::Value rhsVal = buildExpr(c.rhs());
    mlir::Value assignmentVal;

    switch (c.assignment()->kind()) {
    case lang::TK_PLUS_EQ:
    case lang::TK_PLUS_EQ_B:
      assignmentVal = builder.create<mlir::AddFOp>(
          startLoc, buildIndexLoadExpr(c.ident(), c.indices()), rhsVal);
      break;
    case lang::TK_TIMES_EQ:
      assignmentVal = builder.create<mlir::MulFOp>(
          startLoc, buildIndexLoadExpr(c.ident(), c.indices()), rhsVal);
      break;
    default:
      throw mlirgen::Exception("Unsupported operator");
    }

    buildIndexStoreExpr(rhsVal, c.ident(), c.indices());

    // Restore insertion point to point after the outermost loop
    builder.setInsertionPointToEnd(outermost.getParentOp()->getBlock());
  }

  // Returns a map with one entry per output tensor specifying their
  // ranks for the TC definition `def`. If the same tensor is indexed
  // with multiple ranks (e.g., C(i, j) = ... and C(i, j, k) = ..., an
  // exception is thrown.
  std::map<std::string, size_t> collectOutputRanks(const lang::Def &def) {
    std::set<std::string> outParamNames;
    std::map<std::string, size_t> ranks;

    for (const lang::Param &outParam : def.returns())
      outParamNames.insert(outParam.ident().name());

    for (const lang::Comprehension &compr : def.statements()) {
      std::string name = compr.ident().name();
      size_t rank = compr.indices().size();

      if (outParamNames.find(name) != outParamNames.end()) {
        auto it = ranks.find(name);

        if (it != ranks.end()) {
          if (it->second != rank) {
            throw mlirgen::Exception("Multiple ranks found for output tensor " +
                                     name);
          }
        } else {
          ranks.insert({name, rank});
        }
      }
    }

    return std::move(ranks);
  }
};

// Builds an MLIR function with the name `name` from the TC definition
// `def`.
mlir::FuncOp buildMLIRFunction(mlir::MLIRContext &context,
                               const std::string &name, const lang::Def &tc) {
  MLIRGenImpl generator(context);
  return generator.buildFunction(name, tc);
}
} // namespace teckyl