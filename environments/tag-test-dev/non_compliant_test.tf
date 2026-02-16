# Non-compliant resource - missing required tags (does NOT use default_tags)
# This should trigger a validation failure

resource "aws_s3_bucket" "non_compliant_bucket" {
  bucket = "tag-test-non-compliant-bucket-demo"

  # Explicitly setting tags WITHOUT required tags to test validator
  tags = {
    Name = "non-compliant-test"
  }
}
