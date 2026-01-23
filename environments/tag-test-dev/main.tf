# Mimics Cloud Platform setup - minimal default_tags, tags passed to modules
terraform {
  # Backend commented out for local testing
  # backend "s3" {
  # }
}

provider "aws" {
  region = "eu-west-2"

  # Skip credential validation for CI/CD tag scanning
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Cloud Platform only sets these two in default_tags
  # Other required tags must be passed to modules explicitly
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

