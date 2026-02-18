# 🛠️ Tech Stacks — Yarlis Portfolio

> Comprehensive technical documentation for all 6 portfolio products.
> Last updated: 2026-02-18

---

## 📊 Stack Overview

| Product | Frontend | Backend | Database | Auth | Hosting | CI/CD |
|---------|----------|---------|----------|------|---------|-------|
| **Yarlis.com** | Next.js 15 | NestJS | PostgreSQL | Auth0 | Cloud Run | GitHub Actions |
| **Yarlis.ai** | Next.js 15 | NestJS | PostgreSQL | Auth0 | Cloud Run | GitHub Actions |
| **MyBotBox** | Next.js 15 | n8n + NestJS | PostgreSQL | Auth0 | Cloud Run + Firebase | GitHub Actions |
| **SDODS** | React | TypeScript | — | Firebase | npm | GitHub Actions |
| **Yarlis.io** | Next.js 15 | NestJS | PostgreSQL | Auth0 | Cloud Run | GitHub Actions |
| **RapidTriageMe** | Next.js 15 | NestJS | Firestore | Firebase | Firebase Hosting | GitHub Actions |

---

## 1️⃣ Yarlis.com (Core Platform)

> **Role:** Parent company, brand hub, SSO gateway
> **Repo:** [yarlis-platform](https://github.com/siri1410/yarlis-platform)
> **Domain:** yarlis.com

### Tech Stack

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| **Framework** | Next.js | 15.x | App Router, SSR/SSG |
| **Language** | TypeScript | 5.x | Type safety |
| **Styling** | Tailwind CSS | 4.x | Utility-first CSS |
| **UI Components** | Radix UI + shadcn/ui | latest | Accessible components |
| **State** | Zustand | 4.x | Client state |
| **Forms** | React Hook Form + Zod | latest | Validation |
| **API** | NestJS | 10.x | REST + GraphQL |
| **ORM** | Drizzle | latest | Type-safe SQL |
| **Database** | PostgreSQL | 15 | Primary data store |
| **Auth** | Auth0 | SDK v4 | Enterprise SSO |
| **Payments** | Stripe | latest | Billing & subscriptions |
| **Email** | Twilio SendGrid | latest | Transactional email |
| **SMS** | Twilio Verify | latest | 2FA / OTP |
| **Hosting** | Cloud Run | latest | Serverless containers |
| **CDN** | Firebase Hosting | latest | Static assets |
| **DNS** | AWS Route 53 | — | yarlis.com zone |
| **Monitoring** | OpenTelemetry | latest | Observability |

### Directory Structure
```
yarlis-platform/
├── apps/
│   ├── web/              # Next.js frontend
│   ├── api/              # NestJS backend
│   └── admin/            # Admin dashboard
├── packages/
│   ├── ui/               # Shared components
│   ├── config/           # Shared configs
│   └── db/               # Drizzle schema
├── infra/
│   └── terraform/        # IaC
└── turbo.json            # Turborepo config
```

---

## 2️⃣ Yarlis.ai (AI Platform)

> **Role:** AI-powered development & agent orchestration
> **Repo:** [yarlis-platform](https://github.com/siri1410/yarlis-platform) (monorepo)
> **Domain:** yarlis.ai

### Tech Stack

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| **Framework** | Next.js | 15.x | App Router |
| **Language** | TypeScript | 5.x | Type safety |
| **Styling** | Tailwind CSS | 4.x | Styling |
| **UI** | @dnd-kit | latest | Drag-and-drop (Kanban) |
| **State** | Zustand + React Query | latest | State management |
| **API** | NestJS | 10.x | Backend services |
| **AI/LLM** | Anthropic Claude | 4.5 | Primary AI model |
| **AI/LLM** | OpenAI GPT-4 | latest | Fallback model |
| **AI/LLM** | Google Gemini | 2.5 | Alternative model |
| **Agent Framework** | OpenClaw | latest | Agent orchestration |
| **Database** | PostgreSQL | 15 | Structured data |
| **Vector DB** | pgvector | latest | Embeddings |
| **Auth** | Auth0 | SDK v4 | Enterprise SSO |
| **Hosting** | Cloud Run | latest | API services |
| **CDN** | Firebase Hosting | latest | Frontend |
| **DNS** | Cloudflare | — | yarlis.ai zone |

### Key Features
- Mission Control dashboard
- AI agent management (SamJr, Dolly, Nick, Roopa)
- Real-time activity feeds
- Drag-and-drop Kanban boards
- Memory system integration

---

## 3️⃣ MyBotBox (Workflow Automation)

> **Role:** No-code workflow automation marketplace
> **Repo:** [mybotbox-platform](https://github.com/siri1410/mybotbox-platform)
> **Domain:** mybotbox.com

### Tech Stack

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| **Framework** | Next.js | 15.x | App Router |
| **Language** | TypeScript | 5.x | Type safety |
| **Styling** | Tailwind CSS | 4.x | Styling |
| **Workflow Engine** | n8n | latest | Automation backend |
| **API** | NestJS | 10.x | Custom endpoints |
| **ORM** | Drizzle | latest | Type-safe SQL |
| **Database** | PostgreSQL | 15 | Primary store |
| **Auth** | Auth0 | SDK v4 | User authentication |
| **Payments** | Stripe | latest | Subscriptions |
| **Email** | Twilio SendGrid | latest | Notifications |
| **Hosting (API)** | Cloud Run | latest | Backend |
| **Hosting (Web)** | Firebase Hosting | latest | Frontend |
| **Load Balancer** | GCP HTTPS LB | latest | SSL termination |
| **DNS** | AWS Route 53 | — | mybotbox.com zone |

### Architecture
```
                     ┌─────────────────┐
                     │  mybotbox.com   │
                     │ (Firebase Host) │
                     └────────┬────────┘
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
       ┌───────────┐   ┌───────────┐   ┌───────────┐
       │ Cloud Run │   │    n8n    │   │  Stripe   │
       │   (API)   │   │  (Flows)  │   │ (Billing) │
       └─────┬─────┘   └─────┬─────┘   └───────────┘
             │               │
             └───────┬───────┘
                     │
              ┌──────┴──────┐
              │  PostgreSQL │
              │ (Cloud SQL) │
              └─────────────┘
```

### Staging URLs
- **App:** staging-app.mybotbox.com (Cloud Run LB)
- **Firebase:** ystudio-core.web.app

---

## 4️⃣ SDODS (Open Source Core)

> **Role:** Software Development & Operations Data Systems
> **Repo:** [sdods](https://github.com/Yarlis/sdods)
> **Domain:** sdods.com

### Tech Stack

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| **Language** | TypeScript | 5.x | Library code |
| **Build** | tsup | latest | Bundling |
| **Package Manager** | pnpm | latest | Monorepo |
| **Testing** | Vitest | latest | Unit tests |
| **Linting** | ESLint + Prettier | latest | Code quality |
| **CI/CD** | GitHub Actions | — | Publish to npm |
| **Registry** | npm | — | Package distribution |

### Published Packages

| Package | Description | Dependencies |
|---------|-------------|--------------|
| `@sdods/core` | Core utilities | None (zero deps) |
| `@sdods/auth` | Auth abstractions | Firebase, Auth0 (peers) |
| `@sdods/ui` | React components | React, clsx |
| `@sdods/observability` | Logging/metrics | OpenTelemetry (peer) |

### Usage
```typescript
// Install
pnpm add @sdods/core @sdods/auth @sdods/ui

// Use
import { createAuthProvider } from '@sdods/auth';
import { Button } from '@sdods/ui';
```

---

## 5️⃣ Yarlis.io (Developer Tools)

> **Role:** Developer tools and API ecosystem
> **Repo:** [yarlis-platform](https://github.com/siri1410/yarlis-platform) (monorepo)
> **Domain:** yarlis.io

### Tech Stack

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| **Framework** | Next.js | 15.x | App Router |
| **Language** | TypeScript | 5.x | Type safety |
| **API Docs** | Swagger/OpenAPI | 3.x | API documentation |
| **SDK Gen** | OpenAPI Generator | latest | Client SDKs |
| **CLI** | Commander.js | latest | CLI tools |
| **Database** | PostgreSQL | 15 | API data |
| **Auth** | API Keys + Auth0 | latest | Developer auth |
| **Rate Limiting** | Redis | latest | API protection |
| **Hosting** | Cloud Run | latest | APIs |
| **DNS** | AWS Route 53 | — | yarlis.io zone |

### Planned Features
- Developer portal
- API key management
- Usage dashboards
- SDK downloads
- Webhooks management

---

## 6️⃣ RapidTriageMe (Browser Automation)

> **Role:** Browser automation & debugging platform
> **Repo:** [smartrapidtriage](https://github.com/siri1410/smartrapidtriage)
> **Domain:** rapidtriage.me

### Tech Stack

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| **Framework** | Next.js | 15.x | App Router |
| **Language** | TypeScript | 5.x | Type safety |
| **Styling** | Tailwind CSS | 4.x | Styling |
| **Browser Automation** | Playwright | latest | E2E testing |
| **Chrome Extension** | Manifest V3 | — | Browser integration |
| **MCP Server** | TypeScript | — | AI tool protocol |
| **Database** | Firestore | latest | NoSQL storage |
| **Storage** | Firebase Storage | latest | Screenshots/assets |
| **Auth** | Firebase Auth | latest | User management |
| **Hosting** | Firebase Hosting | latest | Frontend |
| **Functions** | Cloud Functions | latest | Backend logic |
| **DNS** | Cloudflare | — | rapidtriage.me zone |

### MCP Tools Available

| Tool | Purpose |
|------|---------|
| `getConsoleLogs()` | Browser console logs |
| `getConsoleErrors()` | Console errors only |
| `getNetworkLogs()` | All network requests |
| `getNetworkErrors()` | Failed requests |
| `takeScreenshot()` | Screenshot current tab |
| `getSelectedElement()` | Inspect DOM element |
| `runAccessibilityAudit()` | A11y audit |
| `runPerformanceAudit()` | Performance check |
| `runSEOAudit()` | SEO analysis |
| `runNextJSAudit()` | Next.js specific audit |
| `runDebuggerMode()` | Complex debugging |
| `runAuditMode()` | Full audit suite |

### Staging URL
- **Firebase:** rapidtriage-me.web.app

---

## 🔧 Shared Infrastructure

### Cloud Providers

| Provider | Services Used |
|----------|--------------|
| **Google Cloud** | Cloud Run, Cloud SQL, Secret Manager, Load Balancer |
| **Firebase** | Hosting, Auth, Firestore, Storage, Functions |
| **AWS** | Route 53 (DNS) |
| **Cloudflare** | DNS (yarlis.ai, rapidtriage.me), CDN |
| **Auth0** | Enterprise SSO, MFA |
| **Stripe** | Payments, Subscriptions |
| **Twilio** | SMS (Verify), Email (SendGrid) |

### Monorepo Structure (Turborepo)

```
yarlis-platform/           # Main monorepo
├── apps/
│   ├── yarlis-web/       # yarlis.com
│   ├── yarlis-ai/        # yarlis.ai
│   ├── yarlis-io/        # yarlis.io
│   └── api/              # Shared API
├── packages/
│   ├── ui/               # @yarlis/ui
│   ├── config/           # @yarlis/config
│   ├── db/               # @yarlis/db
│   └── utils/            # @yarlis/utils
└── turbo.json
```

### Database Strategy

| Product | Database | Prefix | Connection |
|---------|----------|--------|------------|
| Yarlis.com | PostgreSQL | `yl_` | Cloud SQL |
| Yarlis.ai | PostgreSQL | `ya_` | Cloud SQL |
| MyBotBox | PostgreSQL | `mbb_` | Cloud SQL |
| Yarlis.io | PostgreSQL | `yio_` | Cloud SQL |
| RapidTriageMe | Firestore | — | Firebase |
| SDODS | — | — | No DB (library) |

---

## 📋 DevOps Standards

### CI/CD Pipeline

```yaml
# Shared workflow pattern
name: Deploy
on:
  push:
    branches: [main]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - run: pnpm install
      - run: pnpm test
      - run: pnpm build
  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: google-github-actions/deploy-cloudrun@v2
```

### Environment Variables

All secrets stored in **Google Secret Manager**:
- `AUTH0_SECRET`
- `DATABASE_URL`
- `STRIPE_SECRET_KEY`
- `TWILIO_AUTH_TOKEN`

---

*Maintained by SamJr 🦊 | Updated: 2026-02-18*
