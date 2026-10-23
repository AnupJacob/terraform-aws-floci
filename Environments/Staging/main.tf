module "staging_infrastructure" {
  source         = "../../modules"
  environments   = var.environments
  instance_count = var.instance_count
  bucket_name    = "my-${var.s3_environment}-app-bucket"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  # No for_each loop here!
  bucket = "${var.environment}-${var.bucket_name}"
}
