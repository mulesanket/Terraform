//This file is used to declare the resources that will be created

resource "aws_instance" "MyEC2Instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = ["default"]

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}