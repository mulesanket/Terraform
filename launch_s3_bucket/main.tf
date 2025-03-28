// This file is used to define the resources that will be created

resource "aws_s3_bucket" "sanket_s3_bucket" {
  bucket = var.bucket_name
  acl = "private"

  tags = {
    Name        = "sanket_s3_bucket"
    Environment = "Dev"
  }
}
