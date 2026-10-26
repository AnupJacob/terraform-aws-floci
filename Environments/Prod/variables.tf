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

variable "ec2_endpoint" {
  type        = string
  description = "EC2 endpoint url"
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

