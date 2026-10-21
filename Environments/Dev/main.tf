module "dev_infrastructure" {
  source      = "../../modules"
  environment = "dev"
  instance_count = var.instance_count
  bucket_name = "my-${var.dev_env}app-bucket"
}