# Compliant S3 bucket - inherits all required tags from provider default_tags
# Testing checkov-tag-validator v1 release
resource "aws_s3_bucket" "compliant_bucket" {
  bucket = "tag-test-compliant-bucket-demo"
}

resource "aws_s3_bucket_versioning" "compliant_bucket" {
  bucket = aws_s3_bucket.compliant_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "compliant_bucket" {
  bucket = aws_s3_bucket.compliant_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
