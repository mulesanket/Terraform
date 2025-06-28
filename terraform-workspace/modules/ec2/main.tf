# Security group (SSH & outbound)
resource "aws_security_group" "sg" {
  name_prefix = "${var.project}-${var.env}-ec2-"
  vpc_id      = var.vpc_id

  ingress { 
    from_port = 22 
    to_port = 22 
    protocol = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]
    }

  egress  { 
    from_port = 0  
    to_port = 0  
    protocol = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
    }

  tags = {
    Name = "${var.project}-${var.env}-ec2-sg"
    env  = var.env
  }
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "${var.project}-${var.env}-web"
    env  = var.env
  }
}
