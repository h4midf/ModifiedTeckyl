

module {
  llvm.func @vv(%arg0: !llvm<"float*">, %arg1: !llvm<"float*">, %arg2: !llvm.i64, %arg3: !llvm.i64, %arg4: !llvm.i64, %arg5: !llvm<"float*">, %arg6: !llvm<"float*">, %arg7: !llvm.i64, %arg8: !llvm.i64, %arg9: !llvm.i64, %arg10: !llvm<"float*">, %arg11: !llvm<"float*">, %arg12: !llvm.i64, %arg13: !llvm.i64, %arg14: !llvm.i64) {
    %0 = llvm.mlir.undef : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %6 = llvm.mlir.undef : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %7 = llvm.insertvalue %arg5, %6[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %8 = llvm.insertvalue %arg6, %7[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %9 = llvm.insertvalue %arg7, %8[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %10 = llvm.insertvalue %arg8, %9[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %11 = llvm.insertvalue %arg9, %10[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %12 = llvm.mlir.undef : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %13 = llvm.insertvalue %arg10, %12[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %14 = llvm.insertvalue %arg11, %13[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %15 = llvm.insertvalue %arg12, %14[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %16 = llvm.insertvalue %arg13, %15[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %17 = llvm.insertvalue %arg14, %16[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %18 = llvm.mlir.constant(0 : index) : !llvm.i64
    %19 = llvm.extractvalue %5[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %20 = llvm.extractvalue %17[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %21 = llvm.mlir.constant(0 : index) : !llvm.i64
    %22 = llvm.mlir.constant(1 : index) : !llvm.i64
    llvm.br ^bb1(%21 : !llvm.i64)
  ^bb1(%23: !llvm.i64):  // 2 preds: ^bb0, ^bb8
    %24 = llvm.icmp "slt" %23, %20 : !llvm.i64
    llvm.cond_br %24, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    %25 = llvm.mlir.constant(0 : index) : !llvm.i64
    %26 = llvm.mlir.constant(4 : index) : !llvm.i64
    %27 = llvm.mlir.constant(0 : index) : !llvm.i64
    %28 = llvm.mlir.constant(-1 : index) : !llvm.i64
    %29 = llvm.icmp "slt" %19, %27 : !llvm.i64
    %30 = llvm.sub %28, %19 : !llvm.i64
    %31 = llvm.select %29, %30, %19 : !llvm.i1, !llvm.i64
    %32 = llvm.sdiv %31, %26 : !llvm.i64
    %33 = llvm.sub %28, %32 : !llvm.i64
    %34 = llvm.select %29, %33, %32 : !llvm.i1, !llvm.i64
    %35 = llvm.mlir.constant(4 : index) : !llvm.i64
    %36 = llvm.mul %34, %35 : !llvm.i64
    %37 = llvm.mlir.constant(4 : index) : !llvm.i64
    llvm.br ^bb3(%25 : !llvm.i64)
  ^bb3(%38: !llvm.i64):  // 2 preds: ^bb2, ^bb4
    %39 = llvm.icmp "slt" %38, %36 : !llvm.i64
    llvm.cond_br %39, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %40 = llvm.extractvalue %5[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %41 = llvm.mlir.constant(0 : index) : !llvm.i64
    %42 = llvm.mlir.constant(1 : index) : !llvm.i64
    %43 = llvm.mul %38, %42 : !llvm.i64
    %44 = llvm.add %41, %43 : !llvm.i64
    %45 = llvm.getelementptr %40[%44] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %46 = llvm.load %45 : !llvm<"float*">
    %47 = llvm.extractvalue %11[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %48 = llvm.mlir.constant(0 : index) : !llvm.i64
    %49 = llvm.mlir.constant(1 : index) : !llvm.i64
    %50 = llvm.mul %38, %49 : !llvm.i64
    %51 = llvm.add %48, %50 : !llvm.i64
    %52 = llvm.getelementptr %47[%51] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %53 = llvm.load %52 : !llvm<"float*">
    %54 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %55 = llvm.mlir.constant(0 : index) : !llvm.i64
    %56 = llvm.mlir.constant(1 : index) : !llvm.i64
    %57 = llvm.mul %23, %56 : !llvm.i64
    %58 = llvm.add %55, %57 : !llvm.i64
    %59 = llvm.getelementptr %54[%58] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %60 = llvm.load %59 : !llvm<"float*">
    %61 = llvm.fmul %46, %53 : !llvm.float
    %62 = llvm.fadd %61, %60 : !llvm.float
    %63 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %64 = llvm.mlir.constant(0 : index) : !llvm.i64
    %65 = llvm.mlir.constant(1 : index) : !llvm.i64
    %66 = llvm.mul %23, %65 : !llvm.i64
    %67 = llvm.add %64, %66 : !llvm.i64
    %68 = llvm.getelementptr %63[%67] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    llvm.store %62, %68 : !llvm<"float*">
    %69 = llvm.mlir.constant(1 : index) : !llvm.i64
    %70 = llvm.add %38, %69 : !llvm.i64
    %71 = llvm.extractvalue %5[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %72 = llvm.mlir.constant(0 : index) : !llvm.i64
    %73 = llvm.mlir.constant(1 : index) : !llvm.i64
    %74 = llvm.mul %70, %73 : !llvm.i64
    %75 = llvm.add %72, %74 : !llvm.i64
    %76 = llvm.getelementptr %71[%75] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %77 = llvm.load %76 : !llvm<"float*">
    %78 = llvm.extractvalue %11[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %79 = llvm.mlir.constant(0 : index) : !llvm.i64
    %80 = llvm.mlir.constant(1 : index) : !llvm.i64
    %81 = llvm.mul %70, %80 : !llvm.i64
    %82 = llvm.add %79, %81 : !llvm.i64
    %83 = llvm.getelementptr %78[%82] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %84 = llvm.load %83 : !llvm<"float*">
    %85 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %86 = llvm.mlir.constant(0 : index) : !llvm.i64
    %87 = llvm.mlir.constant(1 : index) : !llvm.i64
    %88 = llvm.mul %23, %87 : !llvm.i64
    %89 = llvm.add %86, %88 : !llvm.i64
    %90 = llvm.getelementptr %85[%89] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %91 = llvm.load %90 : !llvm<"float*">
    %92 = llvm.fmul %77, %84 : !llvm.float
    %93 = llvm.fadd %92, %91 : !llvm.float
    %94 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %95 = llvm.mlir.constant(0 : index) : !llvm.i64
    %96 = llvm.mlir.constant(1 : index) : !llvm.i64
    %97 = llvm.mul %23, %96 : !llvm.i64
    %98 = llvm.add %95, %97 : !llvm.i64
    %99 = llvm.getelementptr %94[%98] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    llvm.store %93, %99 : !llvm<"float*">
    %100 = llvm.mlir.constant(2 : index) : !llvm.i64
    %101 = llvm.add %38, %100 : !llvm.i64
    %102 = llvm.extractvalue %5[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %103 = llvm.mlir.constant(0 : index) : !llvm.i64
    %104 = llvm.mlir.constant(1 : index) : !llvm.i64
    %105 = llvm.mul %101, %104 : !llvm.i64
    %106 = llvm.add %103, %105 : !llvm.i64
    %107 = llvm.getelementptr %102[%106] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %108 = llvm.load %107 : !llvm<"float*">
    %109 = llvm.extractvalue %11[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %110 = llvm.mlir.constant(0 : index) : !llvm.i64
    %111 = llvm.mlir.constant(1 : index) : !llvm.i64
    %112 = llvm.mul %101, %111 : !llvm.i64
    %113 = llvm.add %110, %112 : !llvm.i64
    %114 = llvm.getelementptr %109[%113] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %115 = llvm.load %114 : !llvm<"float*">
    %116 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %117 = llvm.mlir.constant(0 : index) : !llvm.i64
    %118 = llvm.mlir.constant(1 : index) : !llvm.i64
    %119 = llvm.mul %23, %118 : !llvm.i64
    %120 = llvm.add %117, %119 : !llvm.i64
    %121 = llvm.getelementptr %116[%120] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %122 = llvm.load %121 : !llvm<"float*">
    %123 = llvm.fmul %108, %115 : !llvm.float
    %124 = llvm.fadd %123, %122 : !llvm.float
    %125 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %126 = llvm.mlir.constant(0 : index) : !llvm.i64
    %127 = llvm.mlir.constant(1 : index) : !llvm.i64
    %128 = llvm.mul %23, %127 : !llvm.i64
    %129 = llvm.add %126, %128 : !llvm.i64
    %130 = llvm.getelementptr %125[%129] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    llvm.store %124, %130 : !llvm<"float*">
    %131 = llvm.mlir.constant(3 : index) : !llvm.i64
    %132 = llvm.add %38, %131 : !llvm.i64
    %133 = llvm.extractvalue %5[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %134 = llvm.mlir.constant(0 : index) : !llvm.i64
    %135 = llvm.mlir.constant(1 : index) : !llvm.i64
    %136 = llvm.mul %132, %135 : !llvm.i64
    %137 = llvm.add %134, %136 : !llvm.i64
    %138 = llvm.getelementptr %133[%137] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %139 = llvm.load %138 : !llvm<"float*">
    %140 = llvm.extractvalue %11[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %141 = llvm.mlir.constant(0 : index) : !llvm.i64
    %142 = llvm.mlir.constant(1 : index) : !llvm.i64
    %143 = llvm.mul %132, %142 : !llvm.i64
    %144 = llvm.add %141, %143 : !llvm.i64
    %145 = llvm.getelementptr %140[%144] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %146 = llvm.load %145 : !llvm<"float*">
    %147 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %148 = llvm.mlir.constant(0 : index) : !llvm.i64
    %149 = llvm.mlir.constant(1 : index) : !llvm.i64
    %150 = llvm.mul %23, %149 : !llvm.i64
    %151 = llvm.add %148, %150 : !llvm.i64
    %152 = llvm.getelementptr %147[%151] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %153 = llvm.load %152 : !llvm<"float*">
    %154 = llvm.fmul %139, %146 : !llvm.float
    %155 = llvm.fadd %154, %153 : !llvm.float
    %156 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %157 = llvm.mlir.constant(0 : index) : !llvm.i64
    %158 = llvm.mlir.constant(1 : index) : !llvm.i64
    %159 = llvm.mul %23, %158 : !llvm.i64
    %160 = llvm.add %157, %159 : !llvm.i64
    %161 = llvm.getelementptr %156[%160] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    llvm.store %155, %161 : !llvm<"float*">
    %162 = llvm.add %38, %37 : !llvm.i64
    llvm.br ^bb3(%162 : !llvm.i64)
  ^bb5:  // pred: ^bb3
    %163 = llvm.mlir.constant(4 : index) : !llvm.i64
    %164 = llvm.mlir.constant(0 : index) : !llvm.i64
    %165 = llvm.mlir.constant(-1 : index) : !llvm.i64
    %166 = llvm.icmp "slt" %19, %164 : !llvm.i64
    %167 = llvm.sub %165, %19 : !llvm.i64
    %168 = llvm.select %166, %167, %19 : !llvm.i1, !llvm.i64
    %169 = llvm.sdiv %168, %163 : !llvm.i64
    %170 = llvm.sub %165, %169 : !llvm.i64
    %171 = llvm.select %166, %170, %169 : !llvm.i1, !llvm.i64
    %172 = llvm.mlir.constant(4 : index) : !llvm.i64
    %173 = llvm.mul %171, %172 : !llvm.i64
    %174 = llvm.mlir.constant(1 : index) : !llvm.i64
    llvm.br ^bb6(%173 : !llvm.i64)
  ^bb6(%175: !llvm.i64):  // 2 preds: ^bb5, ^bb7
    %176 = llvm.icmp "slt" %175, %19 : !llvm.i64
    llvm.cond_br %176, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %177 = llvm.extractvalue %5[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %178 = llvm.mlir.constant(0 : index) : !llvm.i64
    %179 = llvm.mlir.constant(1 : index) : !llvm.i64
    %180 = llvm.mul %175, %179 : !llvm.i64
    %181 = llvm.add %178, %180 : !llvm.i64
    %182 = llvm.getelementptr %177[%181] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %183 = llvm.load %182 : !llvm<"float*">
    %184 = llvm.extractvalue %11[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %185 = llvm.mlir.constant(0 : index) : !llvm.i64
    %186 = llvm.mlir.constant(1 : index) : !llvm.i64
    %187 = llvm.mul %175, %186 : !llvm.i64
    %188 = llvm.add %185, %187 : !llvm.i64
    %189 = llvm.getelementptr %184[%188] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %190 = llvm.load %189 : !llvm<"float*">
    %191 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %192 = llvm.mlir.constant(0 : index) : !llvm.i64
    %193 = llvm.mlir.constant(1 : index) : !llvm.i64
    %194 = llvm.mul %23, %193 : !llvm.i64
    %195 = llvm.add %192, %194 : !llvm.i64
    %196 = llvm.getelementptr %191[%195] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    %197 = llvm.load %196 : !llvm<"float*">
    %198 = llvm.fmul %183, %190 : !llvm.float
    %199 = llvm.fadd %198, %197 : !llvm.float
    %200 = llvm.extractvalue %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %201 = llvm.mlir.constant(0 : index) : !llvm.i64
    %202 = llvm.mlir.constant(1 : index) : !llvm.i64
    %203 = llvm.mul %23, %202 : !llvm.i64
    %204 = llvm.add %201, %203 : !llvm.i64
    %205 = llvm.getelementptr %200[%204] : (!llvm<"float*">, !llvm.i64) -> !llvm<"float*">
    llvm.store %199, %205 : !llvm<"float*">
    %206 = llvm.add %175, %174 : !llvm.i64
    llvm.br ^bb6(%206 : !llvm.i64)
  ^bb8:  // pred: ^bb6
    %207 = llvm.add %23, %22 : !llvm.i64
    llvm.br ^bb1(%207 : !llvm.i64)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
}
