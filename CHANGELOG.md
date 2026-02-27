# Yarlis Portfolio — Changelog

All notable changes across the Yarlis ecosystem are tracked here.

---

## [2026-02-27] — Staging Infrastructure Sprint

### MyBotBox (mybotbox-platform)

#### 🚀 Deployed
- Full staging deployment to Cloud Run (`mybotbox-app-staging` rev 00072→00073)
- Image: `gcr.io/ystudio-core/mybotbox-staging:staging-20260227-*`
- Firebase Functions (6): processKnowledgeBase, triggerKnowledgeProcessing, triggerWebhook, executeWebhook, triggerWorkflowExecution, executeWorkflow
- Firestore rules + indexes deployed
- Storage rules deployed
- Firebase Hosting → `staging-app.mybotbox.com`

#### 🐛 Fixed
- **Auth 500 errors** — `FIREBASE_CLIENT_EMAIL_STAGING` was pointing to prod service account (`mybotbox-prod`) instead of staging (`ystudio-core`). Token verification failed for all logged-in users.
- **Home page redirecting to login** — `isHosted` check didn't include `staging-app.mybotbox.com` or `mybotbox.com` (only `www.mybotbox.com`). Fixed environment detection.
- **Login form prefill** — Removed misleading "QA testing" comment suggesting credentials were prefilled (they weren't, but confusing for devs).

#### 🎨 Improved
- Modernized auth background: replaced old wireframe lines/dots with gradient mesh + subtle grid pattern
- Auth background now uses brand colors (orange accent + purple highlights)
- Consistent with modern SaaS auth page aesthetics

#### 📝 Added
- `INFRASTRUCTURE.md` — Complete verified infrastructure spec (all Cloud Run services, Cloud SQL, Firebase, endpoints)
- `RELEASE-PROCESS.md` — Naming conventions, CI/CD pipeline, release types (Static, DB, API, Feature)
- E2E test suite improvements: fixed auth flow tests, updated test config with correct credentials

#### 🏗️ Infrastructure
- `staging-app.mybotbox.com` — DNS CNAME via Route 53 → Firebase Hosting (replaces `stagingcore.mybotbox.com` typo)
- Removed `stagingcore.mybotbox.com` from Route 53 and Firebase Hosting
- GitHub Cloud Build connection authorized (`github-siri1410`)
- Cloud Build yaml fixed: correct service name (`mybotbox-app-staging`, not `ystudio-app-staging`)

### SmartRapidTriage (smartrapidtriage)

#### 🐛 In Progress
- `rapidtriage.me` returning 522 (Cloudflare origin error) — Firebase custom domain added, awaiting DNS update in Cloudflare

### Portfolio (yarlis-portfolio)

#### 📝 Added
- `OPERATING-SYSTEM.md` — Founder-level execution framework (3-category domain management, weekly playbook, ceremonies)
- `CHANGELOG.md` — This file
- `README.md` — Updated with verified live infrastructure data from GCP/Firebase

### Infrastructure Cost

#### 💰 Optimized
- Downgrading `ystudio-db-budget` from `db-custom-1-3840` ($60+/mo) to `db-f1-micro` (~$8/mo) — saves ~$50/mo
- Total projected GCP spend: ~$55/mo (down from ~$105/mo)

---

## [2026-02-26] — Initial Setup

### Portfolio
- SamJr onboarded as Strategic Execution Partner
- Full portfolio mapped: 6 domains, priority ranked
- 90-day target set: MyBotBox → $1K MRR
- Architecture decision: MyBotBox + SRT independent, shared @sdods packages only
- All workspace files initialized (SOUL.md, USER.md, MEMORY.md, IDENTITY.md)

---

## E2E Test Results (2026-02-27)

### MyBotBox Staging — 128 tests

| Suite | Passed | Failed | Skipped |
|---|---|---|---|
| Auth Flow | 13 | 2 | 0 |
| Workspace Flow | 3 | 4 | 0 |
| Landing/Public Pages | 12 | 1 | 0 |
| Admin Pages | 5 | 0 | 1 |
| API Endpoints | 4 | 0 | 2 |
| Performance | 13 | 0 | 0 |
| Responsive | 8 | 2 | 0 |
| Error Handling | 6 | 1 | 2 |
| Editor/Build Workflow | 3 | 2 | 6 |
| Run Workflow | 3 | 1 | 5 |
| User Journey | 5 | 4 | 0 |
| **Total** | **~75** | **~17** | **~16** |

### Key Failures to Fix
1. **Password Reset page** — route exists but form selector mismatch
2. **Workspace sidebar** — not rendering for Playwright (possible timing/hydration issue)
3. **Build Workflow dialog** — create button not triggering dialog modal
4. **React Error #185** — minified React error in workflow editor (ErrorBoundary catching it)

### Performance (All Pass ✅)
| Page | TTFB | Total |
|---|---|---|
| Home | 207ms | 433ms |
| Login | 160ms | 317ms |
| Pricing | 145ms | 247ms |
| Workspace redirect | — | 1918ms |
| API /workflows | — | 280ms |
| JS Bundle | — | 701KB |
