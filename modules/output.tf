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

output "eks_cluster_endpoint" {
  description = "The endpoint URL for your Kubernetes API control plane"
  value       = { for k, v in module.eks : k => v.cluster_endpoint }
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = { for k, v in module.eks : k => v.cluster_name }
}


output "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the cluster"
  value       = { for k, v in module.eks : k => v.cluster_certificate_authority_data }
}