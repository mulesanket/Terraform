terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "tf-workspace-bucket"
    key            = "env/use-env-specific-statefile.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-workspace-lock-table"
    encrypt        = true
  }
}
