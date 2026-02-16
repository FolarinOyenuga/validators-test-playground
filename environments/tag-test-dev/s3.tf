# =============================================================================
# COMPLIANT RESOURCE - All required tags set at resource level
# =============================================================================
resource "aws_s3_bucket" "compliant_bucket" {
  bucket = "tag-test-compliant-bucket-demo"

  tags = {
    application      = var.application
    business-unit    = var.business_unit
    environment-name = var.environment
    is-production    = var.is_production
    owner            = var.owner
    service-area     = var.service_area
  }
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

# =============================================================================
# NON-COMPLIANT: Missing required tags (only has Name)
# =============================================================================
resource "aws_s3_bucket" "missing_tags" {
  bucket = "tag-test-missing-tags-demo"

  tags = {
    Name = "missing-required-tags"
  }
}

# =============================================================================
# NON-COMPLIANT: Incomplete tags (missing some required tags)
# =============================================================================
resource "aws_s3_bucket" "incomplete_tags" {
  bucket = "tag-test-incomplete-tags-demo"

  tags = {
    application   = var.application
    business-unit = var.business_unit
    # Missing: environment-name, is-production, owner, service-area
  }
}

# =============================================================================
# NON-COMPLIANT: Empty tag values
# =============================================================================
resource "aws_s3_bucket" "empty_tags" {
  bucket = "tag-test-empty-tags-demo"

  tags = {
    application      = var.application
    business-unit    = var.business_unit
    environment-name = ""
    is-production    = ""
    owner            = var.owner
    service-area     = var.service_area
  }
}

# =============================================================================
# NON-COMPLIANT: Whitespace-only tag values
# =============================================================================
resource "aws_s3_bucket" "whitespace_tags" {
  bucket = "tag-test-whitespace-tags-demo"

  tags = {
    application      = var.application
    business-unit    = "   "
    environment-name = var.environment
    is-production    = var.is_production
    owner            = "  "
    service-area     = var.service_area
  }
}
