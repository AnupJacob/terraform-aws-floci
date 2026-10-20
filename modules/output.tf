output "instance_id" {
  description = "Instance Id's of my instances created"
  value = aws_instance.my_instances[*].id
}