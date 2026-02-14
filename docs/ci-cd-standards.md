# 🔄 CI/CD Standards

> Enterprise-grade continuous integration and deployment standards

---

## Pipeline Overview

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    Lint     │───▶│    Test     │───▶│    Build    │───▶│   Deploy    │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
      │                  │                  │                  │
      ▼                  ▼                  ▼                  ▼
   ESLint            Unit Tests         Artifacts          Staging
   TypeScript        Integration        Docker Image       Production
   Prettier          E2E Tests          Static Files       (manual)
```

---

## Required Checks

### All Repositories

| Check | Tool | Required |
|-------|------|----------|
| Lint | ESLint | ✅ Yes |
| Type Check | TypeScript | ✅ Yes |
| Format | Prettier | ✅ Yes |
| Unit Tests | Vitest | ✅ Yes |
| Build | Next.js/NestJS | ✅ Yes |

### Additional (When Applicable)

| Check | Tool | When |
|-------|------|------|
| E2E Tests | Playwright | Has UI |
| API Tests | Supertest | Has API |
| Security Scan | Snyk/Dependabot | All |
| Bundle Analysis | @next/bundle-analyzer | Frontend |

---

## Workflow Structure

### Standard CI Workflow

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - uses: actions/setup-node@v4
      - run: pnpm install
      - run: pnpm lint
      - run: pnpm typecheck

  test:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - uses: actions/setup-node@v4
      - run: pnpm install
      - run: pnpm test
      - uses: codecov/codecov-action@v3

  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - uses: actions/setup-node@v4
      - run: pnpm install
      - run: pnpm build
      - uses: actions/upload-artifact@v4

  deploy-staging:
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main'
    environment: staging
    steps:
      - uses: actions/download-artifact@v4
      - uses: FirebaseExtended/action-hosting-deploy@v0
```

---

## Environment Strategy

| Environment | Trigger | Approval | URL Pattern |
|-------------|---------|----------|-------------|
| Preview | PR | None | `pr-{number}.web.app` |
| Staging | Push to main | None | `{app}-staging.web.app` |
| Production | Manual | Required | `{domain}.com` |

### Environment Protection Rules

**Staging:**
- No approval required
- Auto-deploy on main
- Health check after deploy

**Production:**
- Requires approval from CODEOWNERS
- Only from main branch
- Dolly QA sign-off required
- Health check after deploy

---

## Branch Protection

### Main Branch

```yaml
branch_protection:
  main:
    required_status_checks:
      strict: true
      contexts:
        - lint
        - test
        - build
    required_pull_request_reviews:
      required_approving_review_count: 1
      dismiss_stale_reviews: true
    enforce_admins: true
    restrictions:
      users: []
      teams: []
```

### Rules

| Rule | Main | Develop |
|------|------|---------|
| Require PR | ✅ | ✅ |
| Require reviews | 1 | 0 |
| Require status checks | ✅ | ✅ |
| Dismiss stale reviews | ✅ | ❌ |
| Include admins | ✅ | ❌ |

---

## Secrets Management

### GitHub Secrets

| Secret | Environment | Purpose |
|--------|-------------|---------|
| `FIREBASE_SERVICE_ACCOUNT` | Staging | Firebase deploy |
| `FIREBASE_SERVICE_ACCOUNT_PROD` | Production | Firebase deploy |
| `CODECOV_TOKEN` | All | Coverage reports |
| `SLACK_WEBHOOK_URL` | All | Notifications |

### Secret Naming

```
{SERVICE}_{PURPOSE}_{ENVIRONMENT}

Examples:
- FIREBASE_SERVICE_ACCOUNT_STAGING
- STRIPE_SECRET_KEY_PROD
- OPENAI_API_KEY
```

---

## Artifact Management

### Build Artifacts

```yaml
- uses: actions/upload-artifact@v4
  with:
    name: ${{ matrix.app }}-build
    path: apps/${{ matrix.app }}/out
    retention-days: 7
```

### Retention Policy

| Artifact | Retention |
|----------|-----------|
| PR builds | 3 days |
| Main builds | 7 days |
| Release builds | 90 days |

---

## Notifications

### Slack Integration

```yaml
- name: Notify Slack
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    fields: repo,message,commit,author
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
```

### Notification Rules

| Event | Channel | Mention |
|-------|---------|---------|
| Deploy success | #deployments | None |
| Deploy failure | #deployments | @siri |
| PR merged | #development | None |
| Security alert | #security | @siri |

---

## Health Checks

### Post-Deploy Verification

```bash
#!/bin/bash
# health-check.sh

URLS=(
  "https://yarlis-ai-staging.web.app"
  "https://mybotbox-staging.web.app"
)

for url in "${URLS[@]}"; do
  status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  if [ "$status" != "200" ]; then
    echo "❌ $url returned $status"
    exit 1
  fi
done

echo "✅ All health checks passed"
```

---

## Rollback Procedure

### Automatic Rollback

```yaml
- name: Health Check
  run: ./scripts/health-check.sh

- name: Rollback on Failure
  if: failure()
  run: |
    firebase hosting:rollback --project $PROJECT_ID
    echo "🔄 Rolled back to previous version"
```

### Manual Rollback

```bash
# List recent deployments
firebase hosting:releases:list --project yarlis-platform

# Rollback to specific version
firebase hosting:rollback --version v123 --project yarlis-platform
```

---

## Performance Budget

### Frontend Metrics

| Metric | Budget | Action |
|--------|--------|--------|
| First Load JS | < 150kB | Warn |
| Largest Bundle | < 100kB | Block |
| Build Time | < 5min | Warn |

### Enforcement

```yaml
- name: Check Bundle Size
  run: |
    SIZE=$(du -sk out | cut -f1)
    if [ $SIZE -gt 5000 ]; then
      echo "⚠️ Bundle too large: ${SIZE}kB"
      exit 1
    fi
```

---

*Last updated: 2026-02-14*
