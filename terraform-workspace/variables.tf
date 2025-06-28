variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_engine_ver" {
  type    = string
  default = "8.0"
}

variable "db_instance_size" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
