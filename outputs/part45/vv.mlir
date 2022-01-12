#map0 = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (1)>


module {
  func @vv(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>) {
    %c0 = constant 0 : index
    %0 = dim %arg0, %c0 : memref<?xf32>
    linalg.vecvec  %arg0, %arg1, %arg2 : (memref<?xf32>, memref<?xf32>, memref<?xf32>)
    return
  }
}