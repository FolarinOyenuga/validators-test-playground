# Module input variables for tags - mimics Cloud Platform module pattern
# Teams must pass these when calling the module

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "application" {
  description = "Full name of the application or service"
  type        = string
}

variable "business_unit" {
  description = "Area of the MOJ responsible for this service"
  type        = string
}

variable "environment_name" {
  description = "Name of the environment type for this service"
  type        = string
}

variable "infrastructure_support" {
  description = "Email address of the team responsible this service"
  type        = string
}

variable "is_production" {
  description = "Whether this environment type is production or not"
  type        = string
}

variable "namespace" {
  description = "Name of the namespace these resources are part of"
  type        = string
}

variable "owner" {
  description = "Team responsible for the service"
  type        = string
  default     = ""
}

variable "service_area" {
  description = "Service area the team belongs to"
  type        = string
  default     = ""
}

variable "team_name" {
  description = "Name of the development team responsible for this service"
  type        = string
}
