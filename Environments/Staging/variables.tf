variable "environment" {
  type = string
  default = "staging"
  description = "Staging environment where the application is deployed to"
}

variable "instance_count" {
  default = 2
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

variable "ec2_endpoint" {
  type        = string
  description = "EC2 endpoint url"
}