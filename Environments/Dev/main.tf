module "dev_infrastructure" {
  source         = "../../modules"
  vpc_cidr       = "10.0.0.0/16"
  environments   = var.environments
  instance_count = var.instance_count
  bucket_name    = "my-${var.s3_environment}-app-bucket"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  # No for_each loop here!
  bucket = "${var.s3_environment}-${var.bucket_name}"
}
