//This file is used to declare the variables that will be used in the main.tf file

variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "ami" {
  description = "value of the AMI ID"
  type        = string
  default     = "ami-0e35ddab05955cf57"
}

variable "instance_type" {
  description = "value of the instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "value of the instance keypair"
  type        = string
  default     = "MyLinuxServer-Key"
}

variable "vpc_cidr" {
  description = "This provides vpc cidr"
  type        = string
  default     = 0
}

variable "subnet_cidr" {
  description = "This provides subnet cidr"
  type        = string
  default     = 0

}