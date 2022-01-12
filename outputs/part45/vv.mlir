#map0 = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0)>


module {
  func @vv(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>) {
    %c0 = constant 0 : index
    %0 = dim %arg0, %c0 : memref<?xf32>
    linalg.generic {args_in = 2 : i64, args_out = 1 : i64, indexing_maps = [#map0, #map0, #map1], iterator_types = ["parallel", "reduction"]} %arg0, %arg1, %arg2 {
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):  // no predecessors
      %1 = mulf %arg3, %arg4 : f32
      %2 = addf %1, %arg5 : f32
      linalg.yield %2 : f32
    }: memref<?xf32>, memref<?xf32>, memref<?xf32>
    return
  }
}