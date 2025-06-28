# Subnet group
resource "aws_db_subnet_group" "subnet" {
  name       = "${var.project}-${var.env}-db-subnet"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project}-${var.env}-db-subnet"
    env  = var.env
  }
}

# Security group (allow port 3306 only from VPC)
resource "aws_security_group" "db_sg" {
  name_prefix = "${var.project}-${var.env}-db-"
  vpc_id      = element(split("/", var.private_subnet_ids[0]), 0)

  ingress { 
    from_port = 3306 
    to_port = 3306 
    protocol = "tcp" 
    cidr_blocks = ["10.0.0.0/8"] 
    }

  egress  { 
    from_port = 0   
     to_port = 0   
      protocol = "-1" 
       cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "${var.project}-${var.env}-db-sg"
    env  = var.env
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project}-${var.env}-db"
  engine                  = var.db_engine
  engine_version          = var.db_engine_ver
  instance_class          = var.db_instance_size
  allocated_storage       = 20
  storage_type            = "gp3"
  db_subnet_group_name    = aws_db_subnet_group.subnet.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  multi_az                = true

  tags = {
    Name = "${var.project}-${var.env}-db"
    env  = var.env
  }
}
