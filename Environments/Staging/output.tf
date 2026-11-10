output "private_instance_ids_staging" {
  value = module.staging_infrastructure.my_private_instance_id
}

output "public_instance_ids_staging" {
  value = module.staging_infrastructure.my_public_instance_id
}

output "ecr_staging_repository_name" {
  value = module.staging_infrastructure.ecr_repository_url
}

output "postgres_primary_endpoint" {
  value = module.staging_infrastructure.postgres_primary_endpoint
}

output "eks_cluster_endpoint" {
  value = module.staging_infrastructure.eks_cluster_endpoint
}