//This file is used to declare the resources that will be created

resource "aws_vpc" "mymumbai_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "MumbaiVPC"
  }
}

resource "aws_subnet" "mymumbai_subnet" {
  vpc_id            = aws_vpc.mymumbai_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "MumbaiSubnet"
  }
}

resource "aws_internet_gateway" "mumbai_vpc_internetgateway" {
  vpc_id = aws_vpc.mymumbai_vpc.id

  tags = {
    Name = "MumbaiVPCInternetGateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.mymumbai_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mumbai_vpc_internetgateway.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mymumbai_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "mumbai_vpc_SG" {
  name        = "mumbai-SG"
  description = "Allow SSH"
  vpc_id      = aws_vpc.mymumbai_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Mumbai-SG"
  }
}

resource "aws_instance" "my_mumbai_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.instance_keypair
  vpc_security_group_ids      = [aws_security_group.mumbai_vpc_SG.id]
  subnet_id                   = aws_subnet.mymumbai_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "MumbaiVPCInstance"
  }
}
