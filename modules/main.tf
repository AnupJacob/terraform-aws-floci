
# This standard block queries Floci's local container engine instead of real AWS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
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
  for_each   = toset(var.regions)
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
  for_each   = toset(var.regions)
  vpc_id     = aws_vpc.my_floci_vpc[each.key].id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, (index(var.regions, each.key) * 2) + 2)

  lifecycle {
    create_before_destroy = false # Overrides defaults, forcing deletion first
  }
  tags = {
    Infrastructure = var.infrastructure
    region         = each.key
  }
}

resource "aws_internet_gateway" "floci_igw" {
  for_each = toset(var.regions)
  vpc_id   = aws_vpc.my_floci_vpc[each.key].id

  tags = {
    Infrastructure = var.infrastructure
    region         = each.key
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = toset(var.regions)
  subnet_id      = aws_subnet.my_floci_public_subnet[each.key].id
  route_table_id = aws_route_table.public_route_table[each.key].id
}

resource "aws_route_table" "public_route_table" {
  for_each = toset(var.regions)
  vpc_id   = aws_vpc.my_floci_vpc[each.key].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.floci_igw[each.key].id
  }

  tags = {
    Infrastructure = var.infrastructure
    region         = each.key
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

resource "tls_private_key" "internet_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key" {
  filename        = "${path.module}/internet_private_key.pem"
  content         = tls_private_key.internet_private_key.private_key_pem
  file_permission = "0400" # Safe read-only permissions for SSH keys
}

resource "aws_key_pair" "public_key_pair" {
  key_name   = "internet_private_key"
  public_key = tls_private_key.internet_private_key.private_key_pem
}

resource "aws_instance" "my_public_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.public_instance_type
  for_each               = toset(var.regions)
  subnet_id              = aws_subnet.my_floci_private_subnet[each.key].id
  vpc_security_group_ids = aws_security_group.public_security_group[each.key]
  key_name               = aws_key_pair.public_key_pair.key_name
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