//This file is used to define the variables that will be used in the main.tf file

variable "aws_region" {
  description = "The AWS region to create resources in"
  type       = string
  default    = "ap-northeast-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}