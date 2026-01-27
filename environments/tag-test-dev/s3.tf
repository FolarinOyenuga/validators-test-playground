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

# =============================================================================
# EDGE CASE TESTS
# =============================================================================

# EDGE CASE A: Module with NULL values for required tags (should FAIL)
# Tests that validators treat null as missing/invalid
module "null_tags_bucket" {
  source = "./modules/s3-bucket"

  bucket_name            = "coat-null-tags-bucket"
  application            = var.application
  business_unit          = var.business_unit
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support
  is_production          = var.is_production
  namespace              = var.namespace
  owner                  = null  # Null - should fail
  service_area           = null  # Null - should fail
  team_name              = var.team_name
}

# EDGE CASE B: Module with WHITESPACE-ONLY values (should FAIL - policy decision)
# Tests whether validators catch "   " as invalid
module "whitespace_tags_bucket" {
  source = "./modules/s3-bucket"

  bucket_name            = "coat-whitespace-tags-bucket"
  application            = var.application
  business_unit          = var.business_unit
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support
  is_production          = var.is_production
  namespace              = var.namespace
  owner                  = "   "  # Whitespace only - should fail
  service_area           = "   "  # Whitespace only - should fail
  team_name              = var.team_name
}

# EDGE CASE C: Direct resource relying ONLY on provider default_tags (should PASS)
# Tests that validators correctly read tags_all from plan JSON
# Required tags come from provider default_tags, not explicit tags block
resource "aws_s3_bucket" "default_tags_only" {
  bucket = "coat-default-tags-only-bucket"

  # No explicit tags - relies entirely on provider default_tags
  # The provider's default_tags should populate tags_all in the plan
  # If validator only checks 'tags' and not 'tags_all', this will incorrectly FAIL
}
