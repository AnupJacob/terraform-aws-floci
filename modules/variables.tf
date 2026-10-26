variable "public_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Type of instances of public EC2"
}

variable "private_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Type of instances for private EC2"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "infrastructure" {
  default     = "Terraform"
  type        = string
  description = "Specification for identification if made via terraform config no not"
}

variable "instance_count" {
  type        = number
  description = "Number of instances for each environment"
}

variable "environments" {
  type        = list(string)
  description = "Environment where the application is deployed to"

}

variable "regions" {
  default     = ["eu-west-1", "eu-west-2"]
  type        = list(string)
  description = "Region of Infrastructure"
}

variable "vpc_cidr" {
  type        = string
  description = "The main base CIDR block for this specific environment's VPC"
}

variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key pair passed from the environment level"
}