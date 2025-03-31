//This file is used to declare the variables that will be used in the main.tf file

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "ami" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "EC2 instance keypair"
  type        = string
}

variable "instance_name" {
  description = "Tag name for the EC2 instance"
  type        = string
  default     = "Sanket-EC2-V2"
}
