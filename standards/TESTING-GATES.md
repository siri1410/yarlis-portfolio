# Yarlis Testing Gates Standard

> **Applies to:** All Yarlis ecosystem projects
> **Owner:** Siri Y. | **Last Updated:** 2026-02-28

---

## Branch → Environment → Deploy Strategy

| Branch | Environment | Test Target | Deploy Method |
|---|---|---|---|
| `develop` | Local | `localhost` | None (dev only) |
| `main` | Staging | `staging-app.{domain}` | GitHub Actions → Cloud Run |
| Production tag/release | Production | `{domain}` | **Jenkins Pipeline** |

---

## 4-Layer Test Gate Strategy

| Layer | Trigger | Tests | Target | Time | Blocks? |
|---|---|---|---|---|---|
| **Pre-push hook** | `git push` to main/develop | Smoke (auth + nav) | staging / localhost | ~2 min | ✅ Yes (skip: `--no-verify`) |
| **GitHub Actions — PR** | PR to main | Smoke suite | staging | ~2 min | ✅ Yes |
| **GitHub Actions — Merge to main** | Push to main | Fast (full Chromium) | staging | ~8 min | ✅ Yes |
| **Jenkins — Production** | Release/deploy trigger | Full (all browsers) | production domain | ~20 min | ✅ Yes |

---

## Layer 1: Pre-Push Hook (Local)

**Purpose:** Catch broken code before it leaves your machine.

### Setup
```bash
mkdir -p .githooks
git config core.hooksPath .githooks
```

### `.githooks/pre-push`
```bash
#!/bin/bash
# Yarlis Pre-Push Gate — skip with: git push --no-verify

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$BRANCH" != "main" && "$BRANCH" != "develop" ]]; then
  echo "⏭️  Skipping tests (branch: $BRANCH)"
  exit 0
fi

echo "🔍 Pre-push smoke test on $BRANCH..."
cd "$(git rev-parse --show-toplevel)"

if [[ "$BRANCH" == "main" ]]; then
  ./scripts/e2e-smoke.sh staging
elif [[ "$BRANCH" == "develop" ]]; then
  ./scripts/e2e-smoke.sh local
fi

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  echo "❌ Smoke tests FAILED. Push blocked."
  exit 1
fi
echo "✅ Passed. Pushing..."
exit 0
```

### Rules
- `main` → tests against **staging**
- `develop` → tests against **localhost** (must have dev server running)
- Must complete in **< 3 minutes**
- `--no-verify` escape hatch — CI still catches it

---

## Layer 2: GitHub Actions — PR to Main (CI)

**Purpose:** Gate PRs before merge to main (staging).

```yaml
name: E2E Smoke
on:
  pull_request:
    branches: [main]
concurrency:
  group: e2e-smoke-${{ github.ref }}
  cancel-in-progress: true
jobs:
  smoke:
    name: 🔥 Smoke Tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20, cache: 'npm' }
      - run: npm ci
      - run: npx playwright install chromium --with-deps
      - run: ./scripts/e2e-smoke.sh staging
      - uses: actions/upload-artifact@v4
        if: failure()
        with: { name: smoke-failures, path: '**/test-results/', retention-days: 7 }
```

---

## Layer 3: GitHub Actions — Merge to Main (Staging Deploy)

**Purpose:** Full Chromium validation after merge. Gates staging deployment.

```yaml
name: E2E Fast + Staging Deploy
on:
  push:
    branches: [main]
concurrency:
  group: staging-deploy
  cancel-in-progress: false
jobs:
  test:
    name: ⚡ Fast Tests (Chromium)
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20, cache: 'npm' }
      - run: npm ci
      - run: npx playwright install chromium --with-deps
      - run: ./scripts/e2e-fast.sh staging
      - uses: actions/upload-artifact@v4
        if: always()
        with:
          name: fast-results
          path: |
            **/test-results/screenshots/
            **/playwright-report/
          retention-days: 14

  deploy-staging:
    name: 🚀 Deploy to Staging
    needs: test
    runs-on: ubuntu-latest
    steps:
      # PROJECT-SPECIFIC: Cloud Build submit or gcloud run deploy
      - uses: actions/checkout@v4
      - name: Deploy to Cloud Run (staging)
        run: echo "Deploy staging here"
```

---

## Layer 4: Jenkins — Production Deploy

**Purpose:** Full cross-browser validation before production release. Deployed via Jenkins.

### Jenkinsfile Template
```groovy
pipeline {
    agent any

    environment {
        PLAYWRIGHT_BASE_URL = "https://${env.DOMAIN}"
        NODE_VERSION = '20'
    }

    parameters {
        string(name: 'DOMAIN', defaultValue: 'mybotbox.com', description: 'Production domain')
        string(name: 'IMAGE_TAG', description: 'Docker image tag to deploy')
        booleanParam(name: 'SKIP_TESTS', defaultValue: false, description: 'Skip E2E (emergency only)')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                sh 'npm ci'
                sh 'npx playwright install --with-deps'
            }
        }

        stage('E2E Full - All Browsers') {
            when { expression { !params.SKIP_TESTS } }
            parallel {
                stage('Chromium') {
                    steps {
                        sh './scripts/e2e-full.sh prod --project=chromium'
                    }
                }
                stage('Firefox') {
                    steps {
                        sh './scripts/e2e-full.sh prod --project=firefox'
                    }
                }
                stage('WebKit') {
                    steps {
                        sh './scripts/e2e-full.sh prod --project=webkit'
                    }
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: '**/test-results/**', allowEmptyArchive: true
                    archiveArtifacts artifacts: '**/playwright-report/**', allowEmptyArchive: true
                }
                failure {
                    error('❌ E2E tests failed. Production deploy aborted.')
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                // PROJECT-SPECIFIC: Replace with your deploy command
                sh """
                    gcloud run deploy \${SERVICE_NAME} \\
                        --image=\${IMAGE} \\
                        --region=us-central1 \\
                        --project=\${GCP_PROJECT} \\
                        --platform=managed \\
                        --allow-unauthenticated
                """
            }
        }

        stage('Post-Deploy Smoke') {
            steps {
                sh './scripts/e2e-smoke.sh prod'
            }
            post {
                failure {
                    // Rollback if post-deploy smoke fails
                    sh 'echo "🔴 Post-deploy smoke failed — trigger rollback"'
                }
            }
        }
    }

    post {
        always {
            publishHTML(target: [
                reportDir: 'playwright-report',
                reportFiles: 'index.html',
                reportName: 'E2E Report'
            ])
        }
        failure {
            // Notify on failure
            sh 'echo "❌ Production pipeline failed"'
        }
        success {
            sh 'echo "✅ Production deploy complete"'
        }
    }
}
```

### Jenkins Pipeline Rules
- **Full browser matrix** (Chromium + Firefox + WebKit) runs in **parallel stages**
- Tests run against **production domain** before deploy
- **Post-deploy smoke** validates the live deployment
- `SKIP_TESTS` parameter for **emergencies only** (requires approval)
- Artifacts archived for every run
- HTML report published to Jenkins dashboard
- **Rollback trigger** if post-deploy smoke fails

---

## Flow Diagram

```
develop (local dev)
    │
    ├── git push → pre-push hook (smoke vs localhost) → push allowed
    │
    └── PR to main → GitHub Actions smoke (vs staging) → merge allowed
                          │
                          ▼
                    main (staging)
                          │
                          ├── GitHub Actions fast (vs staging) → staging deploy (Cloud Run)
                          │
                          └── Release trigger
                                  │
                                  ▼
                          Jenkins pipeline
                                  │
                                  ├── E2E full (Chromium ║ Firefox ║ WebKit) vs production
                                  ├── Deploy to production (Cloud Run)
                                  └── Post-deploy smoke vs production
```

---

## Required Scripts

Every project must have in `scripts/`:

| Script | Purpose | Max Time |
|---|---|---|
| `e2e-smoke.sh [staging\|prod\|local]` | Critical paths only | 3 min |
| `e2e-fast.sh [staging\|prod\|local]` | Full suite, Chromium | 10 min |
| `e2e-full.sh [staging\|prod\|local]` | All browsers | 25 min |

---

## Playwright Config Standards

```typescript
{
  fullyParallel: true,
  workers: process.env.CI ? 2 : 4,
  retries: process.env.CI ? 2 : 0,
  use: {
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
    trace: 'on-first-retry',
    actionTimeout: isRemote ? 30000 : 15000,
    navigationTimeout: isRemote ? 45000 : 30000,
  },
}
```

---

## Per-Project Status

| Project | Pre-push | PR Gate | Staging (GHA) | Prod (Jenkins) | Scripts |
|---|---|---|---|---|---|
| **MyBotBox** | ✅ | ✅ | ✅ | ❌ TODO | ✅ |
| **SmartRapidTriage** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |
| **SDODS** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |
| **Yarlis Platform** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |
| **Mission Control** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |

---

## Learnings

1. **Firefox auth is slower** — 60s timeout for `waitForURL` after Firebase redirects
2. **`fullyParallel: true`** cuts runtime 40-60%
3. **`PLAYWRIGHT_BASE_URL`** (not `BASE_URL`) is the correct env var
4. **CI workers = 2** — GitHub runners have 2 vCPU, more workers thrash
5. **Jenkins parallel stages** — run browsers concurrently, not sequentially
6. **Post-deploy smoke is mandatory** — catches deploy-specific issues (env vars, secrets, DNS)
7. **Smoke must stay under 3 min** — anything longer and devs skip it
8. **Sub-agents for test runs** — don't burn main session context polling

---

*Living document. Update as patterns emerge across projects.*
