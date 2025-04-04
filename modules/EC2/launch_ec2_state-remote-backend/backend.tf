//This file is used to configure the backend for the Terraform project

terraform {
  backend "s3" {
    bucket = "its-terraform-project-bucket"
    key    = "trial/terraform.tfstate"
    region = "ap-south-1"
  }
}
