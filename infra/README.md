# 🏗️ Yarlis Platform Infrastructure

## Structure
```
infra/
├── terraform/
│   ├── modules/          # Reusable modules (cloudflare-dns, gcp-project, jenkins, etc.)
│   ├── environments/
│   │   ├── prod/         # Production (yarlis.ai, rapidtriage.me, mybotbox.com)
│   │   ├── staging/      # Staging channels
│   │   └── dev/          # Local dev overrides
│   └── shared/           # Shared variables + backends
│
├── jenkins/
│   ├── pipelines/        # Per-repo Jenkinsfiles
│   ├── shared-libraries/ # Shared Groovy libs (yarlisNotify, yarlisTest, yarlisDeploy)
│   ├── casc/             # Jenkins Configuration as Code (jenkins.yaml)
│   └── docker/           # Jenkins Docker setup
│
├── cloudflare/
│   ├── dns/              # DNS record definitions
│   ├── tunnels/          # Cloudflare Tunnel configs
│   └── workers/          # Edge worker scripts
│
└── scripts/              # Automation scripts (setup, teardown, rotate-secrets)
```

## CI/CD — Jenkins at ci.yarlis.ai
- Internal: http://localhost:8080
- External: https://ci.yarlis.ai
- Auth: Google SSO (siri1410@gmail.com)
- Start: `~/yarlis-jenkins/start.sh`

## Terraform — GCP Foundation
```bash
cd infra/terraform/environments/prod
terraform init
terraform plan
terraform apply
```

## DNS — yarlis.ai (Cloudflare)
| Record | Points To | Purpose |
|--------|-----------|---------|
| ci.yarlis.ai | Cloudflare Tunnel | Jenkins CI |
| api.yarlis.ai | Cloud Run | yarlis.ai API |
| docs.yarlis.ai | Firebase Hosting | Documentation |
| status.yarlis.ai | Status page | Monitoring |

## @sdods Library Integration
All Yarlis services consume `@sdods/*` packages:
- `@sdods/auth` → authentication layer
- `@sdods/ui` → shared components
- `@sdods/observability` → logging + tracing
- `@sdods/themes` → brand tokens

## @yarlisai SDK Integration
AI orchestration across all domains:
- `@yarlisai/contracts` → shared types + YPID
- `@yarlisai/router` → multi-model AI routing
- `@yarlisai/memory` → context memory
- `@yarlisai/sdk` → unified entry point
