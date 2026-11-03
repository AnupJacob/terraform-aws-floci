resource "aws_ecr_repository" "anup_ecr_repo" {
  name                 = "${var.environments[0]}-anup's-my-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = {
    Infrastructure = var.infrastructure
    Environment    = var.environments[0]
    Terraform      = "true"
  }
}