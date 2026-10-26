module "dev_infrastructure" {
  source         = "../../modules"
  vpc_cidr       = "10.0.0.0/16"
  environments   = var.environments
  instance_count = var.instance_count
  bucket_name    = "my-${var.s3_environment}-app-bucket"
  ssh_key_name   = aws_key_pair.public_key_pair_dev.key_name

}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.s3_environment}-${var.bucket_name}"
}

resource "tls_private_key" "internet_private_key_dev" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key_dev" {
  filename        = "${path.module}/internet_private_key_dev.pem"
  content         = tls_private_key.internet_private_key_dev.private_key_pem
  file_permission = "0400" # Safe read-only permissions for SSH keys
}

resource "aws_key_pair" "public_key_pair_dev" {
  key_name   = "internet_private_key_dev"
  public_key = tls_private_key.internet_private_key_dev.private_key_pem
}

