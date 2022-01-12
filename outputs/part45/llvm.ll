; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare i8* @malloc(i64)

declare void @free(i8*)

define void @vv(float* %0, float* %1, i64 %2, i64 %3, i64 %4, float* %5, float* %6, i64 %7, i64 %8, i64 %9, float* %10, float* %11, i64 %12, i64 %13, i64 %14) !dbg !3 {
  %16 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %0, 0, !dbg !7
  %17 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %16, float* %1, 1, !dbg !9
  %18 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %17, i64 %2, 2, !dbg !10
  %19 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %18, i64 %3, 3, 0, !dbg !11
  %20 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %19, i64 %4, 4, 0, !dbg !12
  %21 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %5, 0, !dbg !13
  %22 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %21, float* %6, 1, !dbg !14
  %23 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %22, i64 %7, 2, !dbg !15
  %24 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %23, i64 %8, 3, 0, !dbg !16
  %25 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %24, i64 %9, 4, 0, !dbg !17
  %26 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %10, 0, !dbg !18
  %27 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %26, float* %11, 1, !dbg !19
  %28 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %27, i64 %12, 2, !dbg !20
  %29 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %28, i64 %13, 3, 0, !dbg !21
  %30 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %29, i64 %14, 4, 0, !dbg !22
  %31 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, 3, 0, !dbg !23
  %32 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, 0, !dbg !24
  %33 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, 1, !dbg !25
  %34 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, 2, !dbg !26
  %35 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, 3, 0, !dbg !27
  %36 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %20, 4, 0, !dbg !28
  %37 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %25, 0, !dbg !29
  %38 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %25, 1, !dbg !30
  %39 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %25, 2, !dbg !31
  %40 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %25, 3, 0, !dbg !32
  %41 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %25, 4, 0, !dbg !33
  %42 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, 0, !dbg !34
  %43 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, 1, !dbg !35
  %44 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, 2, !dbg !36
  %45 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, 3, 0, !dbg !37
  %46 = extractvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, 4, 0, !dbg !38
  call void @linalg_vecvec_viewsxf32_viewsxf32_viewsxf32(float* %32, float* %33, i64 %34, i64 %35, i64 %36, float* %37, float* %38, i64 %39, i64 %40, i64 %41, float* %42, float* %43, i64 %44, i64 %45, i64 %46), !dbg !39
  ret void, !dbg !40
}

define void @linalg_vecvec_viewsxf32_viewsxf32_viewsxf32(float* %0, float* %1, i64 %2, i64 %3, i64 %4, float* %5, float* %6, i64 %7, i64 %8, i64 %9, float* %10, float* %11, i64 %12, i64 %13, i64 %14) !dbg !41 {
  %16 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %0, 0, !dbg !42
  %17 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %16, float* %1, 1, !dbg !44
  %18 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %17, i64 %2, 2, !dbg !45
  %19 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %18, i64 %3, 3, 0, !dbg !46
  %20 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %19, i64 %4, 4, 0, !dbg !47
  %21 = alloca { float*, float*, i64, [1 x i64], [1 x i64] }, i64 1, align 8, !dbg !48
  store { float*, float*, i64, [1 x i64], [1 x i64] } %20, { float*, float*, i64, [1 x i64], [1 x i64] }* %21, align 8, !dbg !49
  %22 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %5, 0, !dbg !50
  %23 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %22, float* %6, 1, !dbg !51
  %24 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %23, i64 %7, 2, !dbg !52
  %25 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %24, i64 %8, 3, 0, !dbg !53
  %26 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %25, i64 %9, 4, 0, !dbg !54
  %27 = alloca { float*, float*, i64, [1 x i64], [1 x i64] }, i64 1, align 8, !dbg !55
  store { float*, float*, i64, [1 x i64], [1 x i64] } %26, { float*, float*, i64, [1 x i64], [1 x i64] }* %27, align 8, !dbg !56
  %28 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } undef, float* %10, 0, !dbg !57
  %29 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %28, float* %11, 1, !dbg !58
  %30 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %29, i64 %12, 2, !dbg !59
  %31 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %30, i64 %13, 3, 0, !dbg !60
  %32 = insertvalue { float*, float*, i64, [1 x i64], [1 x i64] } %31, i64 %14, 4, 0, !dbg !61
  %33 = alloca { float*, float*, i64, [1 x i64], [1 x i64] }, i64 1, align 8, !dbg !62
  store { float*, float*, i64, [1 x i64], [1 x i64] } %32, { float*, float*, i64, [1 x i64], [1 x i64] }* %33, align 8, !dbg !63
  call void @_mlir_ciface_linalg_vecvec_viewsxf32_viewsxf32_viewsxf32({ float*, float*, i64, [1 x i64], [1 x i64] }* %21, { float*, float*, i64, [1 x i64], [1 x i64] }* %27, { float*, float*, i64, [1 x i64], [1 x i64] }* %33), !dbg !64
  ret void, !dbg !65
}

declare void @_mlir_ciface_linalg_vecvec_viewsxf32_viewsxf32_viewsxf32({ float*, float*, i64, [1 x i64], [1 x i64] }*, { float*, float*, i64, [1 x i64], [1 x i64] }*, { float*, float*, i64, [1 x i64], [1 x i64] }*)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "vv", linkageName: "vv", scope: null, file: !4, line: 4, type: !5, scopeLine: 4, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "../outputs/part45/llvm.mlir", directory: "/Users/h4mid/Programming/dresden_tasks/build")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 6, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 7, column: 10, scope: !8)
!10 = !DILocation(line: 8, column: 10, scope: !8)
!11 = !DILocation(line: 9, column: 10, scope: !8)
!12 = !DILocation(line: 10, column: 10, scope: !8)
!13 = !DILocation(line: 12, column: 10, scope: !8)
!14 = !DILocation(line: 13, column: 10, scope: !8)
!15 = !DILocation(line: 14, column: 10, scope: !8)
!16 = !DILocation(line: 15, column: 11, scope: !8)
!17 = !DILocation(line: 16, column: 11, scope: !8)
!18 = !DILocation(line: 18, column: 11, scope: !8)
!19 = !DILocation(line: 19, column: 11, scope: !8)
!20 = !DILocation(line: 20, column: 11, scope: !8)
!21 = !DILocation(line: 21, column: 11, scope: !8)
!22 = !DILocation(line: 22, column: 11, scope: !8)
!23 = !DILocation(line: 24, column: 11, scope: !8)
!24 = !DILocation(line: 28, column: 11, scope: !8)
!25 = !DILocation(line: 29, column: 11, scope: !8)
!26 = !DILocation(line: 30, column: 11, scope: !8)
!27 = !DILocation(line: 31, column: 11, scope: !8)
!28 = !DILocation(line: 32, column: 11, scope: !8)
!29 = !DILocation(line: 33, column: 11, scope: !8)
!30 = !DILocation(line: 34, column: 11, scope: !8)
!31 = !DILocation(line: 35, column: 11, scope: !8)
!32 = !DILocation(line: 36, column: 11, scope: !8)
!33 = !DILocation(line: 37, column: 11, scope: !8)
!34 = !DILocation(line: 38, column: 11, scope: !8)
!35 = !DILocation(line: 39, column: 11, scope: !8)
!36 = !DILocation(line: 40, column: 11, scope: !8)
!37 = !DILocation(line: 41, column: 11, scope: !8)
!38 = !DILocation(line: 42, column: 11, scope: !8)
!39 = !DILocation(line: 43, column: 5, scope: !8)
!40 = !DILocation(line: 44, column: 5, scope: !8)
!41 = distinct !DISubprogram(name: "linalg_vecvec_viewsxf32_viewsxf32_viewsxf32", linkageName: "linalg_vecvec_viewsxf32_viewsxf32_viewsxf32", scope: null, file: !4, line: 46, type: !5, scopeLine: 46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!42 = !DILocation(line: 48, column: 10, scope: !43)
!43 = !DILexicalBlockFile(scope: !41, file: !4, discriminator: 0)
!44 = !DILocation(line: 49, column: 10, scope: !43)
!45 = !DILocation(line: 50, column: 10, scope: !43)
!46 = !DILocation(line: 51, column: 10, scope: !43)
!47 = !DILocation(line: 52, column: 10, scope: !43)
!48 = !DILocation(line: 54, column: 10, scope: !43)
!49 = !DILocation(line: 55, column: 5, scope: !43)
!50 = !DILocation(line: 57, column: 10, scope: !43)
!51 = !DILocation(line: 58, column: 11, scope: !43)
!52 = !DILocation(line: 59, column: 11, scope: !43)
!53 = !DILocation(line: 60, column: 11, scope: !43)
!54 = !DILocation(line: 61, column: 11, scope: !43)
!55 = !DILocation(line: 63, column: 11, scope: !43)
!56 = !DILocation(line: 64, column: 5, scope: !43)
!57 = !DILocation(line: 66, column: 11, scope: !43)
!58 = !DILocation(line: 67, column: 11, scope: !43)
!59 = !DILocation(line: 68, column: 11, scope: !43)
!60 = !DILocation(line: 69, column: 11, scope: !43)
!61 = !DILocation(line: 70, column: 11, scope: !43)
!62 = !DILocation(line: 72, column: 11, scope: !43)
!63 = !DILocation(line: 73, column: 5, scope: !43)
!64 = !DILocation(line: 74, column: 5, scope: !43)
!65 = !DILocation(line: 75, column: 5, scope: !43)
