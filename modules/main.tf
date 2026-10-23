
# This standard block queries Floci's local container engine instead of real AWS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "my_public_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.public_instance_type
  count = var.instance_count
  tags = {
    infrastructure=var.infrastructure
  }
}

resource "aws_instance" "my_private_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.private_instance_type
  count = var.instance_count
    tags = {
    infrastructure=var.infrastructure
  }
}


resource "aws_vpc" "my_floci_vpc" {
  for_each   = toset(var.regions)
  cidr_block = var.vpc_cidr
  tags = {
    infrastructure = var.infrastructure
  }
}

resource "aws_subnet" "my_floci_private_subnet" {
  for_each = toset(var.regions)
  vpc_id     = aws_vpc.my_floci_vpc[each.key].id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, (index(var.regions, each.key) * 2) + 1)

  lifecycle {
    create_before_destroy = false # Overrides defaults, forcing deletion first
  }
  tags = {
      Infrastructure = var.infrastructure
  }
}

resource "aws_subnet" "my_floci_public_subnet" {
  for_each = toset(var.regions)
  vpc_id     = aws_vpc.my_floci_vpc[each.key].id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, (index(var.regions, each.key) * 2) + 2)

  lifecycle {
    create_before_destroy = false # Overrides defaults, forcing deletion first
  }
  tags = {
    Infrastructure = var.infrastructure
    region = each.key
  }
}

