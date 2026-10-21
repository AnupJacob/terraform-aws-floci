
# Create a sample S3 Bucket locally for testing
module "my_s3_bucket" {
  source         = "./modules"
  instance_count = var.instance_count
  for_each       = toset(var.environments)

  bucket_name = "my-s3-bucket-standalone"
  environment = each.key
}

# Create a public instances locally for testing
module "my_public_instance" {
  source         = "./modules"
  instance_count = var.instance_count
  for_each       = toset(var.environments)

  environment = each.key
  bucket_name = "my-s3-bucket-public"
}

# Create a private instances locally for testing
module "my_private_instance" {
  source         = "./modules"
  instance_count = var.instance_count
  for_each       = toset(var.environments)

  environment = each.key
  bucket_name = "my-s3-bucket-private"
}
