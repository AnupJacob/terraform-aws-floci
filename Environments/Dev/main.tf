module "dev_infrastructure" {
  source          = "../../modules"
  vpc_cidr        = "10.0.0.0/16"
  environments    = var.environments
  instance_count  = var.instance_count
  bucket_name     = "my-${var.s3_environment}-app-bucket"
  ssh_key_name    = aws_key_pair.public_key_pair_dev.key_name
  master_password = var.master_password
  master_user     = var.master_user
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

/*
module "eks" {
  source = "../../modules"

  # Pass your variables down into the module block
  regions        = [var.region]
  environments   = var.environments
  infrastructure = "terraform-aws-floci-development"

  ssh_key_name    = var.ssh_key
  master_user     = var.master_user
  master_password = var.master_password
  bucket_name     = var.bucket_name

  instance_count = var.instance_count
  vpc_cidr       = var.vpc_cidr
}
*/