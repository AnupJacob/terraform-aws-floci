variable "region" {
  default     = "eu-west-1"
  type        = string
  description = "Region of Infrastructure"
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "s3_endpoint" {
  type = string
}

variable "dynamodb_endpoint" {
  type = string
}

variable "ec2_endpoint" {
  type = string
}