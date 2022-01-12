#map0 = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0)>


module {
  func @mm(%arg0: memref<?x?xi32>, %arg1: memref<?x?xi32>, %arg2: memref<?x?xi32>) {
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %0 = dim %arg0, %c0 : memref<?x?xi32>
    %1 = dim %arg0, %c1 : memref<?x?xi32>
    %2 = dim %arg1, %c1 : memref<?x?xi32>
    affine.for %arg3 = 0 to %0 {
      affine.for %arg4 = 0 to %2 {
        affine.for %arg5 = 0 to %1 {
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
