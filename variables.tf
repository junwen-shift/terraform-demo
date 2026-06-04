variable "environment" {
  description = "Deployment environment (dev / staging / prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

variable "project" {
  description = "Short project name used in resource naming"
  type        = string
  default     = "demo"
}

# ── Tags ──────────────────────────────────────────────────────────────────────
variable "extra_tags" {
  description = "Additional tags to merge with the default tag set"
  type        = map(string)
  default     = {}
}
