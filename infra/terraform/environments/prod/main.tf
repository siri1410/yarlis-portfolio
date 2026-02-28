# ============================================================
# Yarlis Platform — Production Environment
# GCP Org: Yarlis CICD | Region: us-central1
# ============================================================

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google     = { source = "hashicorp/google",     version = "~> 5.0" }
    cloudflare = { source = "cloudflare/cloudflare", version = "~> 4.0" }
    firebase   = { source = "hashicorp/google-beta", version = "~> 5.0" }
  }

  backend "gcs" {
    bucket = "yarlis-terraform-state-prod"
    prefix = "terraform/prod"
  }
}

provider "google" {
  region = var.gcp_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# ── Projects ────────────────────────────────────────────────
module "rapidtriage_project" {
  source          = "../../modules/gcp-project"
  project_id      = "rapidtriage-me"
  project_name    = "RapidTriageME"
  org_id          = var.yarlis_org_id
  billing_account = var.billing_account
  services = [
    "firebase.googleapis.com",
    "firestore.googleapis.com",
    "cloudfunctions.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
  ]
}

module "mybotbox_project" {
  source          = "../../modules/gcp-project"
  project_id      = "mybotbox-prod"
  project_name    = "MyBotBox"
  org_id          = var.yarlis_org_id
  billing_account = var.billing_account
  services = [
    "firebase.googleapis.com",
    "firestore.googleapis.com",
    "cloudfunctions.googleapis.com",
    "secretmanager.googleapis.com",
  ]
}

# ── DNS ─────────────────────────────────────────────────────
module "yarlis_ai_dns" {
  source  = "../../modules/cloudflare-dns"
  zone_id = var.cloudflare_zone_yarlis_ai
  domain  = "yarlis.ai"
}

# ── Jenkins CI ───────────────────────────────────────────────
module "jenkins" {
  source      = "../../modules/jenkins"
  domain      = "ci.yarlis.ai"
  cf_zone_id  = var.cloudflare_zone_yarlis_ai
  cf_token    = var.cloudflare_api_token
  admin_email = var.admin_email
}

# ── IAM ─────────────────────────────────────────────────────
module "iam" {
  source      = "../../modules/gcp-iam"
  org_id      = var.yarlis_org_id
  admin_email = var.admin_email
  service_accounts = {
    "deejr-agent"  = "DEEJR AI Agent — CI/CD + monitoring"
    "jenkins-ci"   = "Jenkins CI service account"
    "firebase-deploy" = "Firebase deployment automation"
  }
}
