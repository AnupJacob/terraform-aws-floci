variable "public_instance_type" {
  type = string
  default = "t3.micro"
  description = "Type of instances of public EC2"
}

variable "private_instance_type" {
  type = string
  default = "t3.micro"
  description = "Type of instances for private EC2"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "environment" {
  type = string
  description = "Environment where the application is deployed to"
}

variable "Infrastructure" {
  default = "Terraform"
  type= string
  description = "Specification for identification if made via terraform config no not"
}

variable "instance_count" {
  type = number
  description = "Number of instances for each environment"
}