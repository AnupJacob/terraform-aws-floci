output "my_private_instance_id" {
  description = "Instance Id of my private instance created"
  value       = aws_instance.my_private_instance[*].id
}

output "my_public_instance_id" {
  description = "Instance ID of my public instance created"
  value       = [for instance in aws_instance.my_public_instance : instance.id]
}

output "ecr_repository_url" {
  description = "The URL of the private container registry"
  value       = aws_ecr_repository.anup_ecr_repo.repository_url
}

output "postgres_primary_endpoint" {
  description = "Send WRITE/transaction workloads to this endpoint"
  value       = { for k, v in aws_db_instance.aws_floci_postgres : k => v.endpoint }
}