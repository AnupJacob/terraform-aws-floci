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
  region                      = "us-east-1"
  access_key                  = "mock_key" # Credentials are not checked locally
  secret_key                  = "mock_secret"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    sqs      = "http://localhost:4566"
  }
}

# Create a sample S3 Bucket locally for testing
resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-learning-sandbox-bucket"
}

