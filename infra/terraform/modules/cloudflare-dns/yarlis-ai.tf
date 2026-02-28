# ============================================================
# yarlis.ai DNS Records
# ============================================================

module "yarlis_ai_dns" {
  source  = "./modules/cloudflare-dns"
  zone_id = var.cloudflare_zone_yarlis_ai
  domain  = "yarlis.ai"
  records = [
    # Jenkins CI (via Cloudflare Tunnel)
    { name = "ci",      type = "CNAME", value = "yarlis-ci-tunnel.cfargotunnel.com", proxied = true },
    # API Gateway
    { name = "api",     type = "CNAME", value = "yarlis-api.run.app",                proxied = true },
    # yarlis.ai main
    { name = "@",       type = "CNAME", value = "yarlis-platform.web.app",           proxied = true },
    # Docs
    { name = "docs",    type = "CNAME", value = "yarlis-docs.web.app",              proxied = true },
    # Monitoring
    { name = "status",  type = "CNAME", value = "yarlis-status.web.app",            proxied = true },
  ]
}
