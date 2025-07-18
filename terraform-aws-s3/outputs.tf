output "images_bucket_name" {
  description = "The name of the S3 bucket for images"
  value       = aws_s3_bucket.images.bucket
}

output "logs_bucket_name" {
  description = "The name of the S3 bucket for logs"
  value       = aws_s3_bucket.logs.bucket
}
