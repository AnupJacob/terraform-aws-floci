variable "dev_env" {
  type = string
  description = "Development environment where the application is deployed to"
}

variable "instance_count" {
  default = 2
  type        = number
  description = "Number of instances for the development environment"
}