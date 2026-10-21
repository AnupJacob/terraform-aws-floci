variable "public_instance_type" {
  type = string
  default = "t3.micro"
  description = "Type of instances of public EC2"
}

variable "private_instance_type" {
  type = string
  default = "r9g.medium"
  description = "Type of instances for private EC2"
}

variable "s3_bucket_name" {
  default = "my-sandbox-bucket"
  type = string
  description = "Name of the s3 bucket"
}