resource "aws_s3_bucket" "my_s3_bucket" {
  for_each = toset(var.environments)
  bucket = "${each.value}-${var.bucket_name}"
}


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
  cidr_block = "10.0.0.0/16"
  tags = {
    infrastructure = var.infrastructure
  }
}

resource "aws_subnet" "main" {
  for_each = toset(var.regions)
  vpc_id     = aws_vpc.my_floci_vpc[each.key].id
  cidr_block = "10.0.1.0/24"

  tags = {
      Infrastructure = var.infrastructure
  }
}

