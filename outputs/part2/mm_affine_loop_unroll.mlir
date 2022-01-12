#map0 = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<()[s0] -> ((s0 floordiv 4) * 4)>
#map6 = affine_map<()[s0] -> (s0)>


module {
  func @mm(%arg0: memref<?x?xi32>, %arg1: memref<?x?xi32>, %arg2: memref<?x?xi32>) {
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %0 = dim %arg0, %c0 : memref<?x?xi32>
    %1 = dim %arg0, %c1 : memref<?x?xi32>
    %2 = dim %arg1, %c1 : memref<?x?xi32>
    affine.for %arg3 = 0 to %0 {
      affine.for %arg4 = 0 to %2 {
        affine.for %arg5 = 0 to #map5()[%1] step 4 {
          %3 = affine.load %arg0[%arg3, %arg5] : memref<?x?xi32>
          %4 = affine.load %arg1[%arg5, %arg4] : memref<?x?xi32>
          %5 = affine.load %arg2[%arg3, %arg4] : memref<?x?xi32>
          %6 = muli %3, %4 : i32
          %7 = addi %6, %5 : i32
          affine.store %7, %arg2[%arg3, %arg4] : memref<?x?xi32>
          %8 = affine.apply #map1(%arg5)
          %9 = affine.load %arg0[%arg3, %8] : memref<?x?xi32>
          %10 = affine.load %arg1[%8, %arg4] : memref<?x?xi32>
          %11 = affine.load %arg2[%arg3, %arg4] : memref<?x?xi32>
          %12 = muli %9, %10 : i32
          %13 = addi %12, %11 : i32
          affine.store %13, %arg2[%arg3, %arg4] : memref<?x?xi32>
          %14 = affine.apply #map2(%arg5)
          %15 = affine.load %arg0[%arg3, %14] : memref<?x?xi32>
          %16 = affine.load %arg1[%14, %arg4] : memref<?x?xi32>
          %17 = affine.load %arg2[%arg3, %arg4] : memref<?x?xi32>
          %18 = muli %15, %16 : i32
          %19 = addi %18, %17 : i32
          affine.store %19, %arg2[%arg3, %arg4] : memref<?x?xi32>
          %20 = affine.apply #map3(%arg5)
          %21 = affine.load %arg0[%arg3, %20] : memref<?x?xi32>
          %22 = affine.load %arg1[%20, %arg4] : memref<?x?xi32>
          %23 = affine.load %arg2[%arg3, %arg4] : memref<?x?xi32>
          %24 = muli %21, %22 : i32
          %25 = addi %24, %23 : i32
          affine.store %25, %arg2[%arg3, %arg4] : memref<?x?xi32>
        }
        affine.for %arg5 = #map5()[%1] to %1 {
          %3 = affine.load %arg0[%arg3, %arg5] : memref<?x?xi32>
          %4 = affine.load %arg1[%arg5, %arg4] : memref<?x?xi32>
          %5 = affine.load %arg2[%arg3, %arg4] : memref<?x?xi32>
          %6 = muli %3, %4 : i32
          %7 = addi %6, %5 : i32
          affine.store %7, %arg2[%arg3, %arg4] : memref<?x?xi32>
        }
      }
    }
    return
  }
}
