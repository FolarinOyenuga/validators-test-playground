# Simple S3 bucket module that mimics Cloud Platform module pattern
# Tags are passed as inputs and applied to resources

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    application            = var.application
    business-unit          = var.business_unit
    environment-name       = var.environment_name
    infrastructure-support = var.infrastructure_support
    is-production          = var.is_production
    namespace              = var.namespace
    owner                  = var.owner
    service-area           = var.service_area
    team-name              = var.team_name
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
