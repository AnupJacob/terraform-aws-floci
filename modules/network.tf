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
    Infrastructure                                             = var.infrastructure
    Name                                                       = "${var.environments[0]}-private-subnet-${each.key}"
    "kubernetes.io/cluster/${var.environments[0]}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                          = "1"
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
    Infrastructure                                             = var.infrastructure
    region                                                     = substr(each.key, 0, length(each.key) - 1)
    Name                                                       = "${var.environments[0]}-public-subnet-${each.key}"
    "kubernetes.io/cluster/${var.environments[0]}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                                   = "1"

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


resource "aws_eip" "nat_eip" {
  for_each = toset(var.regions)
  domain   = "vpc"

  tags = {
    Name = "${var.environments[0]}-nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "my_app_natgateway" {
  for_each      = toset(var.regions)
  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = aws_subnet.my_floci_public_subnet[each.key].id

  tags = {
    Name = "${var.environments[0]}-nat-gateway-${each.key}"
  }
  depends_on = [aws_internet_gateway.floci_igw]
}

resource "aws_route_table" "private_connection" {
  for_each = toset(var.regions)
  vpc_id   = aws_vpc.my_floci_vpc[each.key].id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_app_natgateway[each.key].id
  }

  tags = {
    Name           = "${var.environments[0]}-private-route-table-${each.key}"
    infrastructure = var.infrastructure
  }
}

resource "aws_route_table_association" "private_connection_association" {
  for_each       = toset(var.regions)
  subnet_id      = aws_subnet.my_floci_private_subnet[each.key].id
  route_table_id = aws_route_table.private_connection[each.key].id
}