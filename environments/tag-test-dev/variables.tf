variable "application" {
  description = "Full name of the application or service (and acronym if commonly used)"
  type        = string
  default     = "Tag Validation Test"
}

variable "namespace" {
  description = "Name of the namespace these resources are part of"
  type        = string
  default     = "tag-test-namespace-dev"
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

variable "team_name" {
  description = "Name of the development team responsible for this service"
  type        = string
  default     = "cloud-optimisation"
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

variable "slack_channel" {
  description = "Slack channel name for your team"
  type        = string
  default     = "cloud-optimisation"
}

variable "github_owner" {
  description = "The GitHub organization or individual user account containing the app's code repo"
  type        = string
  default     = "ministryofjustice"
}

variable "github_token" {
  type        = string
  description = "Required by the GitHub Terraform provider"
  default     = ""
}
