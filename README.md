# 🏛️ Yarlis Portfolio

> **AI Automation Infrastructure Company**  
> One ecosystem. Six domains. Compounding leverage.

[![Portfolio Status](https://img.shields.io/badge/Status-Active-green)](https://yarlis.com)
[![Products](https://img.shields.io/badge/Products-6-blue)](portfolio/products.yaml)
[![CICD](https://img.shields.io/badge/CICD-Jenkins%20on%20Cloud%20Run-orange)](https://cicd.yarlis.io)
[![Vault](https://img.shields.io/badge/Secrets-Infisical%20Vault-purple)](https://vault.yarlis.io)
[![Last Updated](https://img.shields.io/badge/Updated-2026--02--28-blue)](#)

---

## 📊 Portfolio Overview

| Domain | Product | Repo | Status | Live | Stack |
|--------|---------|------|--------|------|-------|
| [mybotbox.com](https://mybotbox.com) | **MyBotBox** | [mybotbox-platform](https://github.com/siri1410/mybotbox-platform) | 🟢 Beta | ✅ | Bun · Next.js 15 · Firebase · Cloud Run |
| [rapidtriage.me](https://rapidtriage.me) | **SmartRapidTriage** | [rapidtriageME](https://github.com/siri1410/rapidtriageME) | 🟢 Beta | ✅ | TS · Cloudflare Workers · Wrangler |
| [yarlis.com](https://yarlis.com) | **Yarlis Core** | [yarlis-platform](https://github.com/siri1410/yarlis-platform) | 🟡 Build | ✅ | Next.js 15 · Turborepo · Cloud Run |
| [yarlis.ai](https://yarlis.ai) | **Yarlis AI** | [yarlis-platform](https://github.com/siri1410/yarlis-platform) | 🟡 Build | ❌ | NestJS · LangChain · Multi-model |
| [sdods.com](https://sdods.com) | **SDODS** | [sdods](https://github.com/siri1410/sdods) | 🟡 Build | ❌ | TypeScript · Open Source |
| [yarlis.io](https://yarlis.io) | **Yarlis IO** | [yarlis-platform](https://github.com/siri1410/yarlis-platform) | 🔴 Idea | ❌ | TBD |

---

## 🔱 Shared Platform Infrastructure

| Service | URL | Purpose | Status |
|---------|-----|---------|--------|
| **UIP** (Identity) | [uip](https://github.com/siri1410/uip) | Multi-tenant auth, RBAC, SSO | 🟢 Published |
| **@sdods** (UI Library) | [sdods](https://github.com/siri1410/sdods) | Shared component library | 🟢 Published |
| **CICD** | [cicd.yarlis.io](https://cicd.yarlis.io) | Jenkins on Cloud Run | 🟡 Deploying |
| **Vault** | [vault.yarlis.io](https://vault.yarlis.io) | Infisical secrets portal | 🟡 Setup |

---

## 🏗️ CI/CD Architecture

> **Jenkins on Google Cloud Run** — `cicd.yarlis.io`

```
cicd.yarlis.io (Jenkins LTS)
├── GCP Project:  yarlis-cicd-prod
├── Persistence:  Cloud Filestore NFS 1TB
├── Secrets:      GCP Secret Manager (50+ secrets)
├── Image:        gcr.io/yarlis-cicd-prod/yarlis-jenkins:latest
│
├── 🟢 mybotbox    → staging + production (Cloud Run)
├── 🟢 rapidtriage → staging + production (Cloudflare Workers)
├── 🟡 yarlis-com  → staging + production (Cloud Run)
├── 🟡 yarlis-ai   → staging + production (Cloud Run)
├── 🟡 sdods       → staging + production (npm publish)
└── ⬛ yarlis-io   → parked
```

**Pipeline stages:** Checkout → Install → TypeCheck + Lint → Tests → Security Scan → Build → Container Push → Deploy Staging → Smoke Tests → E2E Tests → **Production Approval Gate** → Deploy Production → Verify

---

## 🔐 Secrets Vault

> **Infisical** self-hosted at `vault.yarlis.io`

| Layer | Technology | Role |
|-------|-----------|------|
| **Portal UI** | Infisical (Cloud Run) | Manage all secrets visually |
| **Backend** | GCP Secret Manager | Storage + audit log |
| **Sync** | Infisical → GCP SM | Auto-sync on save |
| **Runtime** | Cloud Run secret injection | Zero secrets in code |
| **Dev** | `infisical run --` CLI | Pull .env locally |

Secret format: `{domain}-{env}-{variable}` (e.g. `mybotbox-production-stripe-key`)

---

## 🧠 Architecture Decisions

| Decision | Choice | Why |
|----------|--------|-----|
| Monorepo | Turborepo + pnpm | Shared packages across all apps |
| Auth | UIP (NestJS + Prisma) | Owned multi-tenant RBAC + SSO |
| AI Routing | yarlis.ai | Multi-model, cloud-agnostic |
| UI System | @sdods | One design system, all 6 domains |
| CICD | Jenkins on Cloud Run | Central dashboard + manual prod gates |
| Secrets | Infisical → GCP SM | Portal UI + audit + sync |
| Deploy | Cloud Run + CF Workers | Serverless, auto-scaling |

---

## 🎨 Brand Colors

| Product | Primary | Accent |
|---------|---------|--------|
| MyBotBox | `#FF6B35` | `#00D4AA` |
| Yarlis | `#6B3FFA` | `#00D4AA` |
| SmartRapidTriage | `#2563EB` | `#10B981` |
| SDODS | `#8B5CF6` | `#F59E0B` |

---

## 🔗 Resources

| Resource | URL |
|----------|-----|
| CICD Dashboard | [cicd.yarlis.io](https://cicd.yarlis.io) |
| Secrets Vault | [vault.yarlis.io](https://vault.yarlis.io) |
| GitHub | [github.com/siri1410](https://github.com/siri1410) |
| GCP Console | [console.cloud.google.com](https://console.cloud.google.com) |

---

_🔱 DEEJR — Never sleeps on goals. Updated: 2026-02-28_


## 🎨 Design (Figma)

| Domain | Figma Project | Files |
|--------|--------------|-------|
| yarlis.com | [yarlis.com](https://www.figma.com/files/team/1541530489515876113/project/541599622) | — |
| mybotbox.com | [mybotbox.com](https://www.figma.com/files/team/1541530489515876113/project/541617289) | Manus Page Design |
| yarlis.ai | [yarlis.ai](https://www.figma.com/files/team/1541530489515876113/project/557500319) | — |
| yarlis.io | [yarlis.io](https://www.figma.com/files/team/1541530489515876113/project/557500171) | — |
| rapidtriage.me | [rapidtriage.me](https://www.figma.com/files/team/1541530489515876113/project/557500720) | Product Architecture, User Journey, VS Code Extension |
| sdods.com | [sdods.com](https://www.figma.com/files/team/1541530489515876113/project/557500879) | — |

**Figma Team:** Sireesh Yarlagadda (Professional) • Team ID: `1541530489515876113`
