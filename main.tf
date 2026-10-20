terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Redirect all standard AWS requests to your local Floci container
provider "aws" {
  region                      = var.region
  access_key                  = file("./secrets.txt") # Credentials are not checked locally
  secret_key                  = file("./secrets.txt")
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = file("./secrets.txt")
    dynamodb = file("./secrets.txt")
    sqs      = file("./secrets.txt")
  }
}

# Create a sample S3 Bucket locally for testing
module "my_s3_bucket1" {
  source = "./modules"
}

