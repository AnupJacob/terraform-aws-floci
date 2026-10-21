variable "prod_env" {
  type = string
  description = "Production environment where the application is deployed to"
}

variable "instance_count" {
  default = 3
  type        = number
  description = "Number of instances for the Production environment"
}