# MyBotBox System Architecture

## Overview

MyBotBox is a multi-tenant AI workflow automation platform built on a modular monorepo architecture.

## Stack

| Layer | Technology |
|-------|------------|
| Frontend | Next.js 15.4 / React 19 / TypeScript |
| Styling | Tailwind CSS 4 / shadcn/ui |
| Database | PostgreSQL (Drizzle ORM) |
| Auth | Firebase Authentication |
| Realtime | Firebase Realtime Database |
| Storage | Google Cloud Storage |
| Background | Cloud Tasks + Cloud Functions |
| Payments | Stripe |
| AI/LLM | Multi-provider (OpenAI, Anthropic, Google) |
| Hosting | Cloud Run (GCP) |
| CDN | Firebase Hosting |

## Architecture Diagram

```
                    ┌─────────────────┐
                    │  Firebase Hosting│
                    │  (CDN + SSL)    │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │   Cloud Run     │
                    │  (Next.js App)  │
                    └──┬──────────┬───┘
                       │          │
              ┌────────▼──┐  ┌───▼──────────┐
              │ PostgreSQL │  │ Firebase     │
              │ (Cloud SQL)│  │ (Auth+RT+GCS)│
              └───────────┘  └──────────────┘
```

## Key Services

| Service | GCP Name | Project |
|---------|----------|---------|
| Staging App | `mybotbox-app-staging` | ystudio-core |
| Prod App | `mybotbox-app` | mybotbox-prod |
| Staging DB | `ystudio-staging-db` | ystudio-core |
| Prod DB | `mybotbox-db` | mybotbox-prod |

## References

- Full infrastructure spec: `mybotbox-platform/INFRASTRUCTURE.md`
- Release process: `mybotbox-platform/RELEASE-PROCESS.md`
- 104 DB migrations in `packages/db/migrations/`
- 150+ API endpoints
- 30+ tool integrations
