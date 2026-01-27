terraform {
  # Backend commented out for CI - validators use dummy credentials
  # backend "s3" {
  # }
}

provider "aws" {
  region = "eu-west-2"

  # Skip credential validation for CI with dummy credentials
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  default_tags {
    tags = {
      application            = var.application
      business-unit          = var.business_unit
      environment-name       = var.environment
      infrastructure-support = var.infrastructure_support
      is-production          = var.is_production
      owner                  = var.owner
      service-area           = var.service_area
      source-code            = "github.com/FolarinOyenuga/validators-test-playground"
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
      application            = var.application
      business-unit          = var.business_unit
      environment-name       = var.environment
      infrastructure-support = var.infrastructure_support
      is-production          = var.is_production
      owner                  = var.owner
      service-area           = var.service_area
      source-code            = "github.com/FolarinOyenuga/validators-test-playground"
    }
  }
}

