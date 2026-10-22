locals {
  env_region_matrix = {
    for pair in setproduct(var.environments, var.regions) :
    "${pair[0]}_${pair[1]}" => {
      env    = pair[0]
      region = pair[1]
    }
  }
}