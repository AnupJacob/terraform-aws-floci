output "private_instance_ids_prod" {
  value = module.prod_infrastructure.my_private_instance_id
}

output "public_instance_ids_prod" {
  value = module.prod_infrastructure.my_public_instance_id
}

output "ecr_prod_repository_name" {
  value = module.prod_infrastructure.ecr_repository_url
}

output "postgres_primary_endpoint" {
  value = module.prod_infrastructure.postgres_primary_endpoint
}

output "eks_cluster_endpoint" {
  value = module.prod_infrastructure.eks_cluster_endpoint
}

output "eks_cluster_name" {
  value = module.prod_infrastructure.eks_cluster_name
}