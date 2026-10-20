output "public_instance_id_1" {
    value = module.my_public_instance[0].instance_id
}

output "private_instance_id_1" {
    value = module.my_private_instance[0].instance_id
}

output "public_instance_id_2" {
    value = module.my_public_instance[1].instance_id
}

output "private_instance_id_2" {
    value = module.my_private_instance[1].instance_id
}