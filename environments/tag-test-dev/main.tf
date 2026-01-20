terraform {
  # Backend commented out for local testing
  # backend "s3" {
  # }
}

provider "aws" {
  region = "eu-west-2"

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

