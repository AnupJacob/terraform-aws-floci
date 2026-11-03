
# This standard block queries Floci's local container engine instead of real AWS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "public_security_group" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  for_each    = toset(var.regions)
  vpc_id      = aws_vpc.my_floci_vpc[each.key].id

  # Inbound: Allow SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound: Allow web traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: Allow the EC2 instance to reach the Internet freely
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Infrastructure = var.infrastructure
    Name           = "public_security_group"
  }
}

resource "aws_instance" "my_public_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.public_instance_type
  for_each               = toset(var.regions)
  subnet_id              = aws_subnet.my_floci_private_subnet[each.key].id
  vpc_security_group_ids = [aws_security_group.public_security_group[each.key].id]
  key_name               = var.ssh_key_name
  tags = {
    infrastructure = var.infrastructure
  }
}

resource "aws_instance" "my_private_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.private_instance_type
  count         = var.instance_count
  tags = {
    infrastructure = var.infrastructure
  }
}
