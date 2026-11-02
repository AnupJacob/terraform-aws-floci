#For Public subnet
resource "tls_private_key" "internet_private_key_main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key_main" {
  filename        = "${path.module}/internet_private_key_main.pem"
  content         = tls_private_key.internet_private_key_main.private_key_pem
  file_permission = "0400" # Safe read-only permissions for SSH keys
}

resource "aws_key_pair" "public_key_pair_main" {
  key_name   = "internet_private_key_main"
  public_key = tls_private_key.internet_private_key_main.private_key_pem
}

#For Private subnet
resource "tls_private_key" "app_private_key_main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "app_ssh_key_main" {
  filename        = "${path.module}/app_private_key_main.pem"
  content         = tls_private_key.app_private_key_main.private_key_pem
  file_permission = "0400" # Safe read-only permissions for SSH keys
}

resource "aws_key_pair" "app_key_pair_main" {
  key_name   = "app_private_key_main"
  public_key = tls_private_key.app_private_key_main.private_key_pem
}

module "dev_infrastructure" {
  source         = "./modules"
  vpc_cidr       = var.environment_cidrs["dev"]
  environments   = ["dev"]
  instance_count = 2
  bucket_name    = "development"
  ssh_key_name   = aws_key_pair.public_key_pair_main.key_name
}

module "staging_infrastructure" {
  source         = "./modules"
  vpc_cidr       = var.environment_cidrs["staging"]
  environments   = ["staging"]
  instance_count = 2
  bucket_name    = "staging"
  ssh_key_name   = aws_key_pair.public_key_pair_main.key_name
}

module "prod_infrastructure" {
  source         = "./modules"
  vpc_cidr       = var.environment_cidrs["prod"]
  environments   = ["production"]
  instance_count = 3
  bucket_name    = "production"
  ssh_key_name   = aws_key_pair.public_key_pair_main.key_name
}

# Create a public instances locally for testing
module "my_public_instance" {
  source         = "./modules"
  instance_count = var.instance_count
  for_each       = local.env_region_matrix
  ssh_key_name   = aws_key_pair.public_key_pair_main.key_name

  environments = [each.value.env]
  vpc_cidr     = each.value.env
  bucket_name  = "my-s3-bucket-public"
}

# Create a private instances locally for testing
module "my_private_instance" {
  source         = "./modules"
  instance_count = var.instance_count
  ssh_key_name   = aws_key_pair.app_key_pair_main.key_name
  for_each       = local.env_region_matrix

  environments = [each.value.env]
  vpc_cidr     = each.value.env
  bucket_name  = "my-s3-bucket-private"
}

# Create a sample S3 Bucket locally for testing
module "my_s3_bucket" {
  source         = "./modules"
  instance_count = var.instance_count
  ssh_key_name   = aws_key_pair.public_key_pair_main.key_name
  bucket_name    = "my-s3-bucket-standalone"
  for_each       = local.env_region_matrix
  environments   = [each.value.env]
  vpc_cidr       = each.value.env


}
