variable "application" {
  description = "Full name of the application or service (and acronym if commonly used)"
  type        = string
  default     = "Tag Validation Test"
}

variable "business_unit" {
  description = "One of: HMPPS, OPG, LAA, Central Digital, Technology Services, HMCTS, CICA, OCTO"
  type        = string
  default     = "OCTO"
}

variable "service_area" {
  description = "Full name of the Service Area in which your team is based"
  type        = string
  default     = "Cloud Optimisation and Accountability"
}

variable "environment" {
  description = "Name of the environment type for this service"
  type        = string
  default     = "dev"
}

variable "infrastructure_support" {
  description = "Email address of the team responsible this service"
  type        = string
  default     = "cloud-optimisation@digital.justice.gov.uk"
}

variable "is_production" {
  description = "true or false, indicates if infrastructure supports live production services"
  type        = string
  default     = "false"
}

variable "owner" {
  description = "Format: <team-name>: <team-email>"
  type        = string
  default     = "cloud-optimisation: cloud-optimisation@digital.justice.gov.uk"
}

