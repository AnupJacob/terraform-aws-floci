module "prod_infrastructure" {
  source      = "../../modules"
  environment = "Production"
  bucket_name = "my-${var.environment}app-bucket"
  instance_count = var.instance_count
}
