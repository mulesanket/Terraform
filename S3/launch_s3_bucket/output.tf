//This file outputs the name of the S3 bucket that was created

output "bucket_name" {
  value = aws_s3_bucket.sanket_s3_bucket.id
}