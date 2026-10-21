variable "staging_env" {
  type = string
  description = "Staging environment where the application is deployed to"
}

variable "instance_count" {
  default = 2
  type        = number
  description = "Number of instances for the staging environment"
}