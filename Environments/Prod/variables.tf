variable "environment" {
  type        = string
  default     = "production"
  description = "Production environment where the application is deployed to"
}

variable "instance_count" {
  default     = 3
  type        = number
  description = "Number of instances for the Production environment"
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

variable "bucket_name" {
  type        = string
  default     = "production-s3-bucket"
  description = "The name of the S3 bucket"
}

variable "s3_environment" {
  type        = string
  default     = "production"
  description = "S3 bucket environment"
}

variable "environments" {
  default = ["production"]
  type    = list(string)
}

variable "master_user" {
  type        = string
  description = "master username for RDS cluster"
}

variable "master_password" {
  type        = string
  description = "master password for RDS cluster"
}
variable "vpc_cidr" {
  type        = string
  default     = "10.0.1.0/16"
  description = "VPC CIDR for EKS"
}

variable "eks_environment_short" {
  type        = string
  default     = "stag"
  description = "Production environment short string for EKS cluster for length limit fix"
}

variable "ssh_key" {
  type        = string
  description = "SSH Key for RDS and EKS cluster"
}

variable "sts_endpoint" {
  type        = string
  description = "STS endpoint for prod"
}

variable "iam_endpoint" {
  type        = string
  description = "IAM endpoint for roles at prod"
}

variable "eks_endpoint" {
  type        = string
  description = "EKS endpoint at prod"
}

variable "kms_endpoint" {
  type        = string
  description = "KMS endpoint at prod"
}