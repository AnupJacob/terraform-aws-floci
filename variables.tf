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

variable "s3" {
  type = string
}

variable "dynamodb" {
  type = string
}

variable "ec2" {
  type = string
}