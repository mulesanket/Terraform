//This file is used to declare the variables that will be used in the main.tf file

variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "key_name" {
  description = "value of the key pair name"
  type        = string
  default     = "MyLinuxServer-Key"
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