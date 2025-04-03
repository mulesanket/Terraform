//This file is used to create an EC2 instance in the specified environment
//This is used to declare variables and resource types

variable "ami" {
  description = "value of the AMI"
}

variable "instance_type" {
  description = "value of the instance type"
}

variable "key_name" {
  description = "value of the key name"
}

resource "aws_instance" "MyEC2Instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = ["default"]

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}