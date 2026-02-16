terraform {
  # Backend commented out for CI - validators use dummy credentials
  # backend "s3" {
  # }
}

# =============================================================================
# Cloud Platform Pattern: Minimal default_tags at provider level
# Tags are passed to modules/resources, not set globally
# =============================================================================
provider "aws" {
  region = "eu-west-2"

  # Skip credential validation for CI with dummy credentials
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  default_tags {
    tags = {
      source-code   = "github.com/FolarinOyenuga/validators-test-playground"
      slack-channel = var.slack_channel
    }
  }
}

provider "aws" {
  alias  = "london"
  region = "eu-west-2"

  # Skip credential validation for CI with dummy credentials
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  default_tags {
    tags = {
      source-code   = "github.com/FolarinOyenuga/validators-test-playground"
      slack-channel = var.slack_channel
    }
  }
}

