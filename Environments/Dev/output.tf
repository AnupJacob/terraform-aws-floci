output "private_instance_ids_dev" {
  value = module.dev_infrastructure.my_private_instance_id
}

output "public_instance_ids_dev" {
  value = module.dev_infrastructure.my_public_instance_id
}