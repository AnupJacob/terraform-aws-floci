module "dev_infrastructure" {
  source      = "../../modules"
  environment = "Production"
  bucket_name = "my-${var.prod_env}app-bucket"
  instance_count = var.instance_count
}
