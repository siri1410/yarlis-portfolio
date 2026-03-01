# 📦 MyBotBox

> 🎨 **Figma:** [mybotbox.com Design](https://www.figma.com/files/team/1541530489515876113/project/541617289)

> **No-Code Workflow Automation Marketplace**

---

## Overview

| Field | Value |
|-------|-------|
| **Domain** | mybotbox.com |
| **Repo** | [mybotbox-platform](https://github.com/siri1410/mybotbox-platform) |
| **Status** | 🟢 Beta |
| **Category** | Product |
| **Monetization** | SaaS |

## Tech Stack

| Layer | Technology |
|-------|------------|
| **Monorepo** | Turborepo + Bun 1.2.12 |
| **Frontend** | Next.js 15.4, React 19, TypeScript |
| **Styling** | Tailwind CSS 4, shadcn/ui |
| **Database** | PostgreSQL (Drizzle ORM 0.44) |
| **Auth** | Auth0 SDK v4 + Firebase Auth |
| **Realtime** | Firebase Realtime Database |
| **Background Jobs** | Cloud Tasks + Cloud Functions |
| **Payments** | Stripe |
| **AI/LLM** | Anthropic Claude, Google GenAI, AWS Bedrock |
| **Email** | Resend, Twilio SendGrid |
| **Hosting** | Cloud Run (API) + Firebase Hosting (Web) |
| **Load Balancer** | GCP HTTPS LB |
| **Storage** | Google Cloud Storage, AWS S3 |
| **DNS** | AWS Route 53 |
| **Queues** | AWS SQS |
| **Monitoring** | OpenTelemetry, Datadog |
| **Dev Tools** | Biome 2.0, Husky, Vitest, Playwright |

## Architecture

```
┌─────────────────────────────────────────────────┐
│                  Next.js 15 App                  │
│  (React 19, App Router, Server Components)       │
├─────────────────────────────────────────────────┤
│              Firebase Hosting                    │
└───────────────────┬─────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────┐
│              Cloud Run (API)                     │
│  (Auth0 middleware, API routes)                  │
├─────────────────────────────────────────────────┤
│  PostgreSQL     │  Firebase RTDB  │  Cloud Tasks │
│  (Source of     │  (Realtime      │  (Background │
│   truth)        │   presence)     │   jobs)      │
└─────────────────────────────────────────────────┘
```

## Packages

| Package | Purpose |
|---------|---------|
| `apps/sat` | Main web application |
| `apps/docs` | Documentation site |
| `packages/db` | Database schemas (Drizzle) |
| `packages/auth` | Auth utilities |
| `packages/cli` | CLI tool |
| `packages/ts-sdk` | TypeScript SDK |
| `packages/python-sdk` | Python SDK |
| `functions/` | Cloud Functions |

## URLs

| Environment | URL |
|-------------|-----|
| Production | https://mybotbox.com |
| Staging (LB) | https://staging-app.mybotbox.com |
| Firebase | https://ystudio-core.web.app |

## Features

- [x] Landing page
- [x] User authentication (Auth0 + Firebase)
- [x] Signup/Login flows
- [x] Pricing page
- [x] Workflow builder (ReactFlow)
- [x] Real-time collaboration (Firebase RTDB)
- [x] Background job processing (Cloud Tasks)
- [ ] Template marketplace
- [ ] Bot deployment
- [ ] Usage analytics

## Revenue Model

| Tier | Price | Features |
|------|-------|----------|
| Free | $0/mo | 3 workflows, 100 runs/mo |
| Pro | $29/mo | 20 workflows, 5k runs/mo |
| Team | $99/mo | Unlimited workflows, 25k runs/mo |
| Enterprise | Custom | Custom limits, SLA |

---

*Last updated: 2026-02-18*
