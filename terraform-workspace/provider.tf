provider "aws" {
  region = var.aws_region
}

#env variable to initialize the workspace dynamically
locals {
  env = terraform.workspace
}