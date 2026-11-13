terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Development-AWS-Floci"
      name    = "terraform-aws-floci-development"
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
    ecr      = var.ecr_endpoint
    rds      = var.rds_endpoint
    sts      = var.sts_endpoint
    iam      = var.iam_endpoint
    kms      = var.kms_endpoint
    eks      = var.eks_endpoint
  }
}


#Kubernetes provider addition
provider "kubernetes" {
  host                   = module.dev_infrastructure.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.dev_infrastructure.eks_cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.dev_infrastructure.eks_cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.dev_infrastructure.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.dev_infrastructure.eks_cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.dev_infrastructure.eks_cluster_name]
    }
  }
}
