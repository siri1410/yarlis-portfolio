#!/bin/bash
# ============================================================
# Yarlis Vault Setup — Run once to bootstrap GCP Secret Manager
# Usage: bash infra/vault/setup.sh
# Prereqs: gcloud auth login, project set to yarlis-platform
# ============================================================
set -e

PROJECT="yarlis-platform"
WIF_POOL="yarlis-github-pool"
WIF_PROVIDER="yarlis-github-provider"
GITHUB_ORG="siri1410"

echo "🔱 Setting up Yarlis Vault..."

# Enable Secret Manager
gcloud services enable secretmanager.googleapis.com --project=$PROJECT

# ── Workload Identity Federation (keyless GitHub → GCP) ───
echo "🔑 Creating Workload Identity Pool..."
gcloud iam workload-identity-pools create $WIF_POOL \
  --project=$PROJECT \
  --location=global \
  --display-name="Yarlis GitHub Actions Pool"

gcloud iam workload-identity-pools providers create-oidc $WIF_PROVIDER \
  --project=$PROJECT \
  --location=global \
  --workload-identity-pool=$WIF_POOL \
  --display-name="GitHub OIDC Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner,attribute.ref=assertion.ref" \
  --attribute-condition="assertion.repository_owner == '${GITHUB_ORG}'" \
  --issuer-uri="https://token.actions.githubusercontent.com"

POOL_ID=$(gcloud iam workload-identity-pools describe $WIF_POOL \
  --project=$PROJECT --location=global --format="value(name)")

# ── Service Accounts (per domain) ──────────────────────────
for DOMAIN in all rtm mbx yai sdo; do
  SA_NAME="github-actions-${DOMAIN}"
  echo "👤 Creating service account: $SA_NAME"
  
  gcloud iam service-accounts create $SA_NAME \
    --project=$PROJECT \
    --display-name="GitHub Actions — ${DOMAIN}" \
    --description="CI/CD service account for domain: ${DOMAIN}" 2>/dev/null || true

  # Allow GitHub Actions to impersonate this SA (repo-scoped)
  gcloud iam service-accounts add-iam-policy-binding \
    "${SA_NAME}@${PROJECT}.iam.gserviceaccount.com" \
    --project=$PROJECT \
    --role="roles/iam.workloadIdentityUser" \
    --member="principalSet://iam.googleapis.com/${POOL_ID}/attribute.repository/${GITHUB_ORG}/${DOMAIN}"

  # Grant Secret Manager access (read secrets for this domain)
  gcloud projects add-iam-policy-binding $PROJECT \
    --member="serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com" \
    --role="roles/secretmanager.secretAccessor"
done

echo ""
echo "✅ Vault setup complete!"
echo ""
echo "📋 Add these to GitHub Actions workflows:"
echo "  workload_identity_provider: ${POOL_ID}/providers/${WIF_PROVIDER}"
echo "  service_account: github-actions-all@${PROJECT}.iam.gserviceaccount.com"
echo ""
echo "🔐 Now populate secrets:"
echo "  bash infra/vault/populate-secrets.sh"
