terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Production-AWS-Floci"
      name    = "terraform-aws-floci-prod"
    }
  }
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
  access_key                  = var.access_key # Credentials are not checked locally
  secret_key                  = var.secret_key
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3       = var.s3_endpoint
    dynamodb = var.dynamodb_endpoint
    ec2      = var.ec2_endpoint
  }
}
