# TEST CASE 1: Module with ALL required tags (should PASS)
module "compliant_bucket" {
  source = "./modules/s3-bucket"

  bucket_name            = "coat-compliant-test-bucket"
  application            = var.application
  business_unit          = var.business_unit
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support
  is_production          = var.is_production
  namespace              = var.namespace
  owner                  = var.owner
  service_area           = var.service_area
  team_name              = var.team_name
}

# TEST CASE 2: Module with MISSING required tags (should FAIL)
# Missing: owner, service_area
module "non_compliant_bucket" {
  source = "./modules/s3-bucket"

  bucket_name            = "coat-non-compliant-test-bucket"
  application            = var.application
  business_unit          = var.business_unit
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support
  is_production          = var.is_production
  namespace              = var.namespace
  owner                  = ""  # Empty - should fail
  service_area           = ""  # Empty - should fail
  team_name              = var.team_name
}

# TEST CASE 3: Direct resource with missing tags (should FAIL)
# Tests that validators catch both module AND direct resource issues
resource "aws_s3_bucket" "direct_bucket_no_tags" {
  bucket = "coat-direct-no-tags-bucket"

  tags = {
    Name = "Direct bucket with missing required tags"
  }
}
