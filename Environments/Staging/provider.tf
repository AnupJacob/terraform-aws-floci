terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Staging-AWS-Floci"
      name    = "terraform-aws-floci-Staging"
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

#Kubernetes provider addition for eu-west-1
provider "kubernetes" {
  host                   = module.staging_infrastructure.eks_cluster_endpoint[var.regions[0]]
  cluster_ca_certificate = base64decode(module.staging_infrastructure.eks_cluster_certificate_authority_data[var.regions[0]])

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.staging_infrastructure.eks_cluster_name[var.regions[0]]]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.staging_infrastructure.eks_cluster_endpoint[var.regions[0]]
    cluster_ca_certificate = base64decode(module.staging_infrastructure.eks_cluster_certificate_authority_data[var.regions[0]])

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.staging_infrastructure.eks_cluster_name[var.regions[0]]]
    }
  }
}

#Kubernetes provider addition for eu-west-2 (Aliased)
provider "kubernetes" {
  alias                  = "west2"
  host                   = module.staging_infrastructure.eks_cluster_endpoint[var.regions[1]]
  cluster_ca_certificate = base64decode(module.staging_infrastructure.eks_cluster_certificate_authority_data[var.regions[1]])

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.staging_infrastructure.eks_cluster_name[var.regions[1]]]
  }
}

provider "helm" {
  alias = "west2"
  kubernetes {
    host                   = module.staging_infrastructure.eks_cluster_endpoint[var.regions[1]]
    cluster_ca_certificate = base64decode(module.staging_infrastructure.eks_cluster_certificate_authority_data[var.regions[1]])

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.staging_infrastructure.eks_cluster_name[var.regions[1]]]
    }
  }
}