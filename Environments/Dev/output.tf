output "private_instance_ids_dev" {
  value = module.dev_infrastructure.my_private_instance_id
}

output "public_instance_ids_dev" {
  value = module.dev_infrastructure.my_public_instance_id
}

output "ecr_dev_repository_name" {
  value = module.dev_infrastructure.ecr_repository_url
}

output "postgres_primary_endpoint" {
  value = module.dev_infrastructure.postgres_primary_endpoint
}

output "eks_cluster_endpoint" {
  value       = module.eks.eks_cluster_endpoint
}