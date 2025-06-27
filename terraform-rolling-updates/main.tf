# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnet IDs for the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Just pick the first 2 subnet IDs
locals {
  two_subnet_ids = slice(data.aws_subnets.default.ids, 0, 2)

  instances = {
    app1 = 0
    app2 = 1
    app3 = 0
  }
}

# Security Group
resource "aws_security_group" "app_sg" {
  name        = "T-rolling-updates-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]
  subnets            = local.two_subnet_ids
}

# Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

# Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# EC2 Instances
resource "aws_instance" "app" {
  for_each = local.instances

  ami                         = var.virginia_ami_id
  instance_type               = var.virginia_instance_type
  subnet_id                   = local.two_subnet_ids[each.value]
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = true
  key_name                    = var.virginia_key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y httpd
              echo "Hello from instance ${each.key}" > /var/www/html/index.html
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF

  tags = {
    Name = each.key
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Attach Instances to ALB Target Group
resource "aws_lb_target_group_attachment" "attachment" {
  for_each         = aws_instance.app
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = each.value.id
  port             = 80
}
