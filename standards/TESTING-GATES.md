# Yarlis Testing Gates Standard

> **Applies to:** All Yarlis ecosystem projects (MyBotBox, SmartRapidTriage, SDODS, Yarlis Platform, Mission Control)
> **Owner:** Siri Y. | **Last Updated:** 2026-02-28

---

## 3-Layer Test Gate Strategy

Every project MUST implement these gates before going to production. No exceptions.

| Layer | Trigger | Tests | Time | Blocks? |
|---|---|---|---|---|
| **Pre-push hook** | `git push` to main/develop | Auth + Nav (smoke) | ~2 min | ✅ Yes (skip: `--no-verify`) |
| **GitHub Actions — PR** | Any PR to main | Smoke suite | ~2 min | ✅ Yes |
| **GitHub Actions — Push** | Merge to main | Full Chromium | ~8 min | ✅ Yes |
| **GitHub Actions — Manual** | Dispatch `full` | All 3 browsers | ~20 min | Optional |

---

## Layer 1: Pre-Push Hook (Local)

**Purpose:** Catch broken code before it leaves your machine.

### Setup
```bash
mkdir -p .githooks
git config core.hooksPath .githooks
```

### Template: `.githooks/pre-push`
```bash
#!/bin/bash
# Yarlis Pre-Push Gate — skip with: git push --no-verify

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$BRANCH" != "main" && "$BRANCH" != "develop" ]]; then
  echo "⏭️  Skipping tests (branch: $BRANCH)"
  exit 0
fi

echo "🔍 Pre-push smoke test on $BRANCH..."
echo "   (skip: git push --no-verify)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cd "$(git rev-parse --show-toplevel)"
./scripts/e2e-smoke.sh staging

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  echo "❌ Smoke tests FAILED. Push blocked."
  exit 1
fi
echo "✅ Passed. Pushing..."
exit 0
```

### Rules
- Runs **auth + navigation** tests only (fastest critical paths)
- Target: **staging** for main, **localhost** for develop
- Must complete in **< 3 minutes** or developers will skip it
- `--no-verify` escape hatch exists but should be rare

---

## Layer 2: GitHub Actions — PR Gate (CI)

**Purpose:** Prevent broken PRs from merging. Visible to reviewers.

### Template
```yaml
name: E2E Smoke
on:
  pull_request:
    branches: [main, develop]
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

### Rules
- **Required check** — PR cannot merge if smoke fails
- Chromium only, 2 workers
- Upload failure artifacts for debugging

---

## Layer 3: GitHub Actions — Push Gate (CD)

**Purpose:** Full validation after merge, before deploy triggers.

### Template
```yaml
name: E2E Fast
on:
  push:
    branches: [main]
concurrency:
  group: e2e-fast-main
  cancel-in-progress: true
jobs:
  fast:
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
```

### Rules
- Full suite, Chromium only
- Screenshots uploaded every run (visual regression)
- Must pass before deploy workflow triggers

---

## Layer 4: Full Browser Matrix (Manual / Release)

**Purpose:** Cross-browser validation before releases.

```yaml
name: E2E Full
on:
  workflow_dispatch:
    inputs:
      target: { description: 'Target URL', default: 'https://staging-app.mybotbox.com' }
jobs:
  full:
    name: 🔬 Full (${{ matrix.browser }})
    runs-on: ubuntu-latest
    strategy:
      matrix:
        browser: [chromium, firefox, webkit]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20, cache: 'npm' }
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npx playwright test --project=${{ matrix.browser }} --reporter=line --workers=2
        env:
          PLAYWRIGHT_BASE_URL: ${{ inputs.target }}
      - uses: actions/upload-artifact@v4
        if: always()
        with: { name: full-${{ matrix.browser }}, path: '**/test-results/', retention-days: 30 }
```

### Rules
- **Manual trigger only** — don't burn CI on every push
- Run before every **production deploy** and **release tag**

---

## Required Scripts

Every project must have these in `scripts/`:

| Script | Purpose | Max Time |
|---|---|---|
| `e2e-smoke.sh [staging\|prod\|local]` | Critical paths only | 3 min |
| `e2e-fast.sh [staging\|prod\|local]` | Full suite, primary browser | 10 min |
| `e2e-full.sh [staging\|prod\|local]` | All browsers | 25 min |

### Script Template
```bash
#!/bin/bash
set -e
ENV="${1:-staging}"
case "$ENV" in
  staging) export PLAYWRIGHT_BASE_URL="https://staging-app.YOURDOMAIN.com" ;;
  prod)    export PLAYWRIGHT_BASE_URL="https://YOURDOMAIN.com" ;;
  local)   unset PLAYWRIGHT_BASE_URL ;;
esac
echo "🚀 E2E [$0] against: ${PLAYWRIGHT_BASE_URL:-localhost}"
npx playwright test --config=YOUR_CONFIG --project=chromium --reporter=line --workers=4 $TEST_FILES
```

---

## Playwright Config Standards

```typescript
{
  fullyParallel: true,                         // Parallel within files
  workers: process.env.CI ? 2 : 4,             // 2 in CI (2 vCPU), 4 local
  retries: process.env.CI ? 2 : 0,             // Retry in CI only
  reporter: [['html'], ['list']],
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

| Project | Pre-push | PR Gate | Push Gate | Full Gate | Scripts |
|---|---|---|---|---|---|
| **MyBotBox** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **SmartRapidTriage** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |
| **SDODS** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |
| **Yarlis Platform** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |
| **Mission Control** | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO | ❌ TODO |

---

## Learnings

1. **Firefox auth is slower** — set timeout to 60s for `waitForURL` after Firebase auth redirects
2. **`fullyParallel: true`** cuts runtime 40-60% vs sequential
3. **`PLAYWRIGHT_BASE_URL`** (not `BASE_URL`) is the correct env var for Playwright config
4. **Starter overlays intercept clicks** — use `force: true` or dismiss first
5. **CI workers = 2** — GitHub runners have 2 vCPU, more workers thrash
6. **Upload artifacts always** — screenshots are your debug lifeline
7. **`--no-verify` is tracked** — if you skip hooks, CI still catches it
8. **Smoke must stay under 3 min** — anything longer and devs skip it every time
9. **Sub-agents for test runs** — don't burn main session context polling test output

---

*Living document. Update as patterns emerge across projects.*
