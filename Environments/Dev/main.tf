module "dev_infrastructure" {
  source         = "../../modules"
  environments    = var.environments
  instance_count = var.instance_count
  bucket_name    = "my-${var.s3_environment}-app-bucket"
}
