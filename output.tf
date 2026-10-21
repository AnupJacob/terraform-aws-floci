output "private_instance_ids_dev" {
  value = module.my_private_instance["dev"].my_private_instance_id
}

output "public_instance_ids_dev" {
  value = module.my_public_instance["dev"].my_public_instance_id
}

output "private_instance_ids_staging" {
  value = module.my_private_instance["staging"].my_private_instance_id
}

output "public_instance_ids_staging" {
  value = module.my_public_instance["staging"].my_public_instance_id
}

output "private_instance_ids_prod" {
  value = module.my_private_instance["prod"].my_private_instance_id
}

output "public_instance_ids_prod" {
  value = module.my_public_instance["prod"].my_public_instance_id
}