module "staging_infrastructure" {
  source         = "../../modules"
  vpc_cidr       = "10.1.0.0/16"
  environments   = var.environments
  instance_count = var.instance_count
  bucket_name    = "my-${var.s3_environment}-app-bucket"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.environment}-${var.bucket_name}"
}
