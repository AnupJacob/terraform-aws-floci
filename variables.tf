variable "regions" {
  default     = ["eu-west-1", "eu-west-2"]
  type        = list(string)
  description = "Region of Infrastructure"
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

variable "environments" {
  type        = list(string)
  description = "Environments to be deployed to"
  default     = ["development", "staging", "prod"]
}

variable "instance_count" {
  type        = number
  description = "Number of instances for this environment"
  default     = 2 # <--- This makes the argument optional!
}

variable "s3_environment" {
  default = "development"
  type    = string
}

variable "region" {
  default = "eu-west-1"
  type    = string
}

variable "environment_cidrs" {
  type = map(string)
  default = {
    dev     = "10.1.0.0/16"
    staging = "10.2.0.0/16"
    prod    = "10.3.0.0/16"
  }
}