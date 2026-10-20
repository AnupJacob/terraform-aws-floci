resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-sandbox-bucket"
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

resource "aws_instance" "my_instances" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}

