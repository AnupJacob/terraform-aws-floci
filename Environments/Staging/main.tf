module "staging_infrastructure" {
  source      = "../../modules"
  environment = "Production"
  bucket_name = "my-${var.staging_env}app-bucket"
  instance_count = var.instance_count
}