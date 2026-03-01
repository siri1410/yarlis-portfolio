# Vault Status — Last Updated 2026-03-01

## Bootstrap
| Step | Status |
|------|--------|
| GCP Secret Manager enabled | ✅ |
| Workload Identity Pool (`yarlis-github-pool`) | ✅ |
| OIDC Provider (`yarlis-github-provider`) | ✅ |
| Service accounts (all, rtm, mbx, yai, sdo, yrl) | ✅ |
| WIF bindings (pool → SA) | ✅ |
| Secret Manager access granted | ✅ |

## WIF Provider (for GitHub secrets)
```
projects/1034667185264/locations/global/workloadIdentityPools/yarlis-github-pool/providers/yarlis-github-provider
```

## Secrets Populated
| Secret ID | Status | Notes |
|-----------|--------|-------|
| `ypid_rtm_prod_firebase-token` | ✅ v1 | Rotate every 180d |
| `ypid_rtm_staging_firebase-token` | ✅ v1 | Same token as prod for now |
| `ypid_rtm_staging_stripe-secret-key` | ✅ v1 | TEST key (`sk_test_...`) |
| `ypid_rtm_staging_stripe-publishable-key` | ✅ v1 | TEST key |
| `ypid_rtm_prod_anthropic-api-key` | ✅ v1 | Rotated 2026-03-01 |
| `ypid_yai_prod_anthropic-api-key` | ✅ v1 | Rotated 2026-03-01 |
| `ypid_all_prod_npm-token` | ✅ v1 | Automation token |
| `ypid_all_prod_cloudflare-token` | ✅ v1 | DNS-only scope |
| `ypid_rtm_prod_stripe-secret-key` | ⏳ Pending | Need live Stripe key |
| `ypid_mbx_prod_firebase-token` | ⏳ Pending | MyBotBox not started |
| `ypid_mbx_prod_stripe-secret-key` | ⏳ Pending | MyBotBox not started |
| `ypid_yrl_prod_jwt-secret` | ⏳ Pending | yarlis.com not started |

## GitHub Secrets — Add to Each Repo
### smartrapidtriage (NEXT ACTION)
| Secret Name | Value |
|-------------|-------|
| `GCP_WIF_PROVIDER` | `projects/1034667185264/locations/global/workloadIdentityPools/yarlis-github-pool/providers/yarlis-github-provider` |
| `GCP_WIF_SA_RTM` | `github-actions-rtm@yarlis-platform.iam.gserviceaccount.com` |

### yarlis-portfolio
| Secret Name | Value |
|-------------|-------|
| `GCP_WIF_PROVIDER` | (same as above) |
| `GCP_WIF_SA_ALL` | `github-actions-all@yarlis-platform.iam.gserviceaccount.com` |

## Key Lessons Learned
- Use `admin@yarlis.com` (not personal Gmail) for all GCP org operations
- `gcloud secrets create` first time, `versions add` for updates
- `--condition=None` required when project already has conditional IAM policies
- POOL_ID must be fetched fresh — do not assume it from pool name
- Never paste live API keys in chat — use vault populate script
- Firebase CI token (`login:ci`) is deprecated — migrate to SA key + GOOGLE_APPLICATION_CREDENTIALS
- WIF attribute-condition is mandatory — without it any GitHub repo could get tokens

## Next Steps
1. ⬜ Add GitHub secrets to `smartrapidtriage` repo (2 values — see above)
2. ⬜ Copy `.github/workflows/rapidtriage.yml` from yarlis-portfolio → smartrapidtriage
3. ⬜ Push a commit to smartrapidtriage → trigger first pipeline run
4. ⬜ Rotate Firebase token to SA key (replace deprecated login:ci)
5. ⬜ Add live Stripe key when going to production
6. ⬜ Populate MyBotBox secrets when that repo is active
