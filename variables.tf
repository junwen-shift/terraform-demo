# ── General ──────────────────────────────────────────────────────────────────
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "xx"
}

variable "location" {
  description = "Azure region to deploy resources into"
  type        = string
  default     = "West Europe"
}

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

# ── Resource Group ────────────────────────────────────────────────────────────
variable "resource_group_name" {
  description = "Name of the resource group. Defaults to rg-<project>-<environment>."
  type        = string
  default     = null
}

# ── Tags ──────────────────────────────────────────────────────────────────────
variable "extra_tags" {
  description = "Additional tags to merge with the default tag set"
  type        = map(string)
  default     = {}
}
