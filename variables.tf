variable "region" {
  default     = "eu-west-1"
  type        = string
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
  type    = list(string)
  default = ["dev", "staging", "prod"]
}

variable "instance_count" {
  type        = number
  description = "Number of instances for this environment"
  default     = 2 # <--- This makes the argument optional!
}