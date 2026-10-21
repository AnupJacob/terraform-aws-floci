resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = var.bucket_name
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
}

resource "aws_instance" "my_private_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.private_instance_type
}
