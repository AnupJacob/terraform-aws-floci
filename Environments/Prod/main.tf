module "prod_infrastructure" {
  source         = "../../modules"
  vpc_cidr       = "10.2.0.0/16"
  environments   = var.environments
  bucket_name    = "my-${var.environment}app-bucket"
  instance_count = var.instance_count
  ssh_key_name   = aws_key_pair.public_key_pair_prod.key_name
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.s3_environment}-${var.bucket_name}"
}

resource "aws_key_pair" "public_key_pair_prod" {
  key_name   = "internet_private_key_prod"
  public_key = tls_private_key.internet_private_key_prod.private_key_pem
}

resource "tls_private_key" "internet_private_key_prod" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key_prod" {
  filename        = "${path.module}/internet_private_key_prod.pem"
  content         = tls_private_key.internet_private_key_prod.private_key_pem
  file_permission = "0400" # Safe read-only permissions for SSH keys
}