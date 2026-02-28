# ============================================================
# Production vars — DO NOT COMMIT sensitive values
# Use: terraform apply -var-file="secrets.tfvars" (gitignored)
# ============================================================
gcp_region                 = "us-central1"
cloudflare_zone_yarlis_ai  = "fa13928b50658984761c6cdec6a34511"
admin_email                = "siri1410@gmail.com"

# yarlis_org_id      = "SET_IN_SECRETS"
# billing_account    = "SET_IN_SECRETS"
# cloudflare_api_token = "SET_IN_SECRETS"
