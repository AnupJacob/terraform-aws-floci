module "prod_infrastructure" {
  source         = "../../modules"
  vpc_cidr       = "10.2.0.0/16"
  environments   = var.environments
  bucket_name    = "my-${var.environment}app-bucket"
  instance_count = var.instance_count
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.s3_environment}-${var.bucket_name}"
}

