module "staging_infrastructure" {
  source         = "../../modules"
  vpc_cidr       = "10.1.0.0/16"
  environments   = var.environments
  instance_count = var.instance_count
  bucket_name    = "my-${var.s3_environment}-app-bucket"
  ssh_key_name   = aws_key_pair.public_key_pair_staging.key_name

}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.environment}-${var.bucket_name}"
}

resource "tls_private_key" "internet_private_key_staging" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key_staging" {
  filename        = "${path.module}/internet_private_key_staging.pem"
  content         = tls_private_key.internet_private_key_staging.private_key_pem
  file_permission = "0400" # Safe read-only permissions for SSH keys
}

resource "aws_key_pair" "public_key_pair_staging" {
  key_name   = "internet_private_key_staging"
  public_key = tls_private_key.internet_private_key_staging.private_key_pem
}