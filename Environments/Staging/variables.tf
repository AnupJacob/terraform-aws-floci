variable "environment" {
  type        = string
  default     = "staging"
  description = "Staging environment where the application is deployed to"
}

variable "environments" {
  type        = list(string)
  default     = ["staging"]
  description = "Development environment where the application is deployed to"
}


variable "instance_count" {
  default     = 2
  type        = number
  description = "Number of instances for the staging environment"
}

variable "access_key" {
  type        = string
  description = "Access key variable"
}

variable "secret_key" {
  type        = string
  description = "Secret key variable"
}

variable "s3_endpoint" {
  type        = string
  description = "S3 endpoint url"
}

variable "dynamodb_endpoint" {
  type        = string
  description = "DynamoDB endpoint url"
}

variable "rds_endpoint" {
  type        = string
  description = "RDS endpoint url"
}

variable "ec2_endpoint" {
  type        = string
  description = "EC2 endpoint url"
}

variable "ecr_endpoint" {
  type        = string
  description = "ECR endpoint url"
}

variable "region" {
  default = "eu-west-1"
  type    = string
}

variable "s3_environment" {
  type        = string
  default     = "staging"
  description = "S3 bucket environment"
}

variable "bucket_name" {
  type        = string
  default     = "staging-s3-bucket"
  description = "The name of the S3 bucket"
}

variable "master_user" {
  type        = string
  description = "master username for EKS and RDS cluster"
}

variable "master_password" {
  type        = string
  description = "master password for EKS and RDS cluster"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.1.0/16"
  description = "VPC CIDR for EKS"
}

variable "eks_environment_short" {
  type        = string
  default     = "stag"
  description = "Staging environment short string for EKS cluster for length limit fix"
}

variable "ssh_key" {
  type        = string
  description = "SSH Key for RDS and EKS cluster"
}