

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
    %20 = llvm.bitcast %5 : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }"> to !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %21 = llvm.bitcast %11 : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }"> to !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %22 = llvm.bitcast %17 : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }"> to !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %23 = llvm.extractvalue %20[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %24 = llvm.extractvalue %20[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %25 = llvm.extractvalue %20[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %26 = llvm.extractvalue %20[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %27 = llvm.extractvalue %20[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %28 = llvm.extractvalue %21[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %29 = llvm.extractvalue %21[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %30 = llvm.extractvalue %21[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %31 = llvm.extractvalue %21[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %32 = llvm.extractvalue %21[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %33 = llvm.extractvalue %22[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %34 = llvm.extractvalue %22[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %35 = llvm.extractvalue %22[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %36 = llvm.extractvalue %22[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %37 = llvm.extractvalue %22[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    llvm.call @linalg_vecvec_viewsxf32_viewsxf32_viewsxf32(%23, %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %36, %37) : (!llvm<"float*">, !llvm<"float*">, !llvm.i64, !llvm.i64, !llvm.i64, !llvm<"float*">, !llvm<"float*">, !llvm.i64, !llvm.i64, !llvm.i64, !llvm<"float*">, !llvm<"float*">, !llvm.i64, !llvm.i64, !llvm.i64) -> ()
    llvm.return
  }
  llvm.func @linalg_vecvec_viewsxf32_viewsxf32_viewsxf32(%arg0: !llvm<"float*">, %arg1: !llvm<"float*">, %arg2: !llvm.i64, %arg3: !llvm.i64, %arg4: !llvm.i64, %arg5: !llvm<"float*">, %arg6: !llvm<"float*">, %arg7: !llvm.i64, %arg8: !llvm.i64, %arg9: !llvm.i64, %arg10: !llvm<"float*">, %arg11: !llvm<"float*">, %arg12: !llvm.i64, %arg13: !llvm.i64, %arg14: !llvm.i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.undef : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %6 = llvm.mlir.constant(1 : index) : !llvm.i64
    %7 = llvm.alloca %6 x !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }"> : (!llvm.i64) -> !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">
    llvm.store %5, %7 : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">
    %8 = llvm.mlir.undef : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %9 = llvm.insertvalue %arg5, %8[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %10 = llvm.insertvalue %arg6, %9[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %11 = llvm.insertvalue %arg7, %10[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %12 = llvm.insertvalue %arg8, %11[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %13 = llvm.insertvalue %arg9, %12[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %14 = llvm.mlir.constant(1 : index) : !llvm.i64
    %15 = llvm.alloca %14 x !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }"> : (!llvm.i64) -> !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">
    llvm.store %13, %15 : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">
    %16 = llvm.mlir.undef : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %17 = llvm.insertvalue %arg10, %16[0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %18 = llvm.insertvalue %arg11, %17[1] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %19 = llvm.insertvalue %arg12, %18[2] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %20 = llvm.insertvalue %arg13, %19[3, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %21 = llvm.insertvalue %arg14, %20[4, 0] : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }">
    %22 = llvm.mlir.constant(1 : index) : !llvm.i64
    %23 = llvm.alloca %22 x !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }"> : (!llvm.i64) -> !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">
    llvm.store %21, %23 : !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">
    llvm.call @_mlir_ciface_linalg_vecvec_viewsxf32_viewsxf32_viewsxf32(%7, %15, %23) : (!llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">, !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">, !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_linalg_vecvec_viewsxf32_viewsxf32_viewsxf32(!llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">, !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">, !llvm<"{ float*, float*, i64, [1 x i64], [1 x i64] }*">) attributes {llvm.emit_c_interface}
}
