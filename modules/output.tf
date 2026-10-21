output "my_private_instance_id" {
  description = "Instance Id of my private instance created"
  value = aws_instance.my_private_instance.id
}

output "my_public_instance_id" {
  description = "Instance ID of my public instance created"
  value = aws_instance.my_public_instance.id
}
