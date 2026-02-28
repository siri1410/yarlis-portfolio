# ============================================================
# Yarlis Platform — Shared Terraform Variables
# Used across all environments (prod, staging, dev)
# ============================================================

variable "yarlis_org_id" {
  description = "GCP Organization ID for Yarlis"
  type        = string
}

variable "billing_account" {
  description = "GCP Billing Account ID"
  type        = string
}

variable "gcp_region" {
  description = "Primary GCP region"
  type        = string
  default     = "us-central1"
}

variable "cloudflare_zone_yarlis_ai" {
  description = "Cloudflare Zone ID for yarlis.ai"
  type        = string
  default     = "fa13928b50658984761c6cdec6a34511"
}

variable "cloudflare_zone_rapidtriage" {
  description = "Cloudflare Zone ID for rapidtriage.me"
  type        = string
}

variable "admin_email" {
  description = "Primary admin email"
  type        = string
  default     = "siri1410@gmail.com"
}

# Yarlis ecosystem domains
variable "domains" {
  description = "All Yarlis domains"
  type = map(object({
    name        = string
    project_id  = string
    cf_zone_id  = string
    firebase    = bool
    has_ci      = bool
  }))
  default = {
    yarlis_ai = {
      name       = "yarlis.ai"
      project_id = "yarlis-platform"
      cf_zone_id = "fa13928b50658984761c6cdec6a34511"
      firebase   = false
      has_ci     = true
    }
    rapidtriage = {
      name       = "rapidtriage.me"
      project_id = "rapidtriage-me"
      cf_zone_id = ""
      firebase   = true
      has_ci     = true
    }
    mybotbox = {
      name       = "mybotbox.com"
      project_id = "mybotbox-prod"
      cf_zone_id = ""
      firebase   = true
      has_ci     = true
    }
    sdods = {
      name       = "sdods.com"
      project_id = "sdods-prod"
      cf_zone_id = ""
      firebase   = false
      has_ci     = false
    }
  }
}
