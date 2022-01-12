#map0 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>


module {
  func @mm(%arg0: memref<?x?xi32>, %arg1: memref<?x?xi32>, %arg2: memref<?x?xi32>) {
    %c0 = constant 0 : index
    %0 = dim %arg0, %c0 : memref<?x?xi32>
    %c1 = constant 1 : index
    %1 = dim %arg0, %c1 : memref<?x?xi32>
    %c1_0 = constant 1 : index
    %2 = dim %arg1, %c1_0 : memref<?x?xi32>
    linalg.generic {args_in = 2 : i64, args_out = 1 : i64, indexing_maps = [#map0, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"]} %arg0, %arg1, %arg2 {
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):  // no predecessors
      %3 = muli %arg3, %arg4 : i32
      %4 = addi %3, %arg5 : i32
      linalg.yield %4 : i32
    }: memref<?x?xi32>, memref<?x?xi32>, memref<?x?xi32>
    return
  }
}