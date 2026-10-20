output "public_instance_id_1" {
  description = "Public instance ID 1"
  value       = module.my_public_instance[0].instance_id
}

output "private_instance_id_1" {
  description = "private instance ID 1"
  value       = module.my_private_instance[0].instance_id
}

output "public_instance_id_2" {
  description = "Public instance ID s"
  value       = module.my_public_instance[1].instance_id
}

output "private_instance_id_2" {
  description = "private instance ID 2"
  value       = module.my_private_instance[1].instance_id
}