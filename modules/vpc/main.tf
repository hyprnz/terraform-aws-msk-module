locals {
  create_vpc         = var.create_vpc
  vpc_name           = var.vpc_name
  cidr_block         = var.cidr_block
  availability_zones = data.aws_availability_zones.available.names
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets

  num_public_subnets  = "${local.create_vpc ? length(local.public_subnets) : 0}"
  num_private_subnets = "${local.create_vpc ? length(local.private_subnets) : 0}"
}

resource "aws_vpc" "this" {
  count = local.create_vpc ? 1 : 0

  cidr_block = local.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = local.num_public_subnets

  vpc_id            = aws_vpc.this[0].id
  cidr_block        = element(concat(local.public_subnets, list("")), count.index)
  availability_zone = element(local.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "${format("%s-Public-%s", local.vpc_name, element(local.availability_zones, count.index))}"
  }
}

resource "aws_subnet" "private" {
  count = local.num_private_subnets

  vpc_id            = aws_vpc.this[0].id
  cidr_block        = element(concat(local.private_subnets, list("")), count.index)
  availability_zone = element(local.availability_zones, count.index)

  tags = {
    Name = format("%s-Private-%s", local.vpc_name, element(local.availability_zones, count.index))
  }
}

resource "aws_route_table" "public" {
  count = local.num_public_subnets > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = format("%s-Public-%s", local.vpc_name, element(local.availability_zones, count.index))
  }
}

resource "aws_route" "public_internet_gateway" {
  count = local.num_public_subnets > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table_association" "public" {
  count = local.num_public_subnets > 0 ? local.num_public_subnets : 0

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table" "private" {
  count = local.num_private_subnets > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = format("%s-Private-%s", local.vpc_name, element(local.availability_zones, count.index))
  }
}

resource "aws_route_table_association" "private" {
  count = local.num_private_subnets > 0 ? local.num_private_subnets : 0

  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private[0].id
}

resource "aws_internet_gateway" "this" {
  count = local.num_public_subnets > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = format("%s", local.vpc_name)
  }
}
