# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-${var.env}-vpc"
    env  = var.env
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.project}-${var.env}-igw"
  }
}

# Create two public & two private subnets across AZ-a/b
locals {
  azs           = slice(data.aws_availability_zones.available.names, 0, 2)
  public_cidrs  = [cidrsubnet(var.cidr_block, 8, 0), cidrsubnet(var.cidr_block, 8, 1)]
  private_cidrs = [cidrsubnet(var.cidr_block, 8, 10), cidrsubnet(var.cidr_block, 8, 11)]
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public" {
  for_each                = tomap({ for idx, az in local.azs : idx => az })
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.public_cidrs[tonumber(each.key)]
  availability_zone       = each.value
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.env}-public-${each.value}"
    env  = var.env
    tier = "public"
  }
}

resource "aws_subnet" "private" {
  for_each          = tomap({ for idx, az in local.azs : idx => az })
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.private_cidrs[tonumber(each.key)]
  availability_zone = each.value
  tags = {
    Name = "${var.project}-${var.env}-private-${each.value}"
    env  = var.env
    tier = "private"
  }
}

# Public route table (IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project}-${var.env}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway + private route table
resource "aws_eip" "nat" {
  tags = {
    Name = "${var.project}-${var.env}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id
  tags          = { Name = "${var.project}-${var.env}-nat-gw" }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.project}-${var.env}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
