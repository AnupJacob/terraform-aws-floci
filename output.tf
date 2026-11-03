output "ecr_dev_repository_name" {
  description = "ECR repository name for the development environment"
  value       = module.dev_infrastructure.ecr_repository_url
}

output "ecr_staging_repository_name" {
  description = "ECR repository name for the development environment"
  value       = module.staging_infrastructure.ecr_repository_url
}


output "ecr_prod_repository_name" {
  description = "ECR repository name for the development environment"
  value       = module.prod_infrastructure.ecr_repository_url
}