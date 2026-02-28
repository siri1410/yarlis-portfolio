# ============================================================
# Cloudflare DNS Module — Yarlis Platform
# Manages DNS records for all Yarlis domains
# ============================================================

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "zone_id"  { type = string }
variable "domain"   { type = string }
variable "records"  {
  type = list(object({
    name    = string
    type    = string
    value   = string
    proxied = optional(bool, true)
    ttl     = optional(number, 1)
  }))
  default = []
}

# Standard records every domain gets
resource "cloudflare_record" "records" {
  for_each = { for r in var.records : r.name => r }
  zone_id  = var.zone_id
  name     = each.value.name
  type     = each.value.type
  value    = each.value.value
  proxied  = each.value.proxied
  ttl      = each.value.ttl
}

output "records" {
  value = cloudflare_record.records
}
