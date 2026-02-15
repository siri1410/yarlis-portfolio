# 🏛️ Yarlis Portfolio

> **AI Automation Infrastructure Company**
> One ecosystem, multiple revenue streams, compounding leverage.

[![Portfolio Status](https://img.shields.io/badge/Status-Active-green)](https://yarlis.com)
[![Products](https://img.shields.io/badge/Products-6-blue)](portfolio/products.yaml)
[![Domains](https://img.shields.io/badge/Domains-6-purple)](portfolio/domains.yaml)

---

## 📊 Portfolio Overview

| Domain | Product | Repo | Status | Category | Monetization |
|--------|---------|------|--------|----------|--------------|
| [yarlis.com](https://yarlis.com) | Yarlis Core | [yarlis-platform](https://github.com/siri1410/yarlis-platform) | 🟡 Build | Platform | Subscription |
| [yarlis.ai](https://yarlis.ai) | Yarlis AI | [yarlis-platform](https://github.com/siri1410/yarlis-platform) | 🟢 Beta | AI | Enterprise |
| [mybotbox.com](https://mybotbox.com) | MyBotBox | [mybotbox-platform](https://github.com/siri1410/mybotbox-platform) | 🟢 Beta | Product | SaaS |
| [sdods.com](https://sdods.com) | SDODS | [sdods](https://github.com/siri1410/sdods) | 🟡 Build | Platform | Open Core |
| [yarlis.io](https://yarlis.io) | Yarlis IO | [yarlis-platform](https://github.com/siri1410/yarlis-platform) | 🔴 Idea | Product | Usage-based |
| [rapidtriage.me](https://rapidtriage.me) | SmartRapidTriage | [smartrapidtriage](https://github.com/siri1410/smartrapidtriage) | 🟢 Beta | Healthcare | Per-seat |

### Status Legend
- 🔴 **Idea** — Concept phase
- 🟡 **Build** — Active development
- 🟢 **Beta** — Testing with users
- 🔵 **Prod** — Live and monetizing

---

## 🎯 Strategy

### Platform Ecosystem

```
                    ┌─────────────────┐
                    │   yarlis.com    │
                    │ (Parent + Auth) │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│   yarlis.ai   │   │  mybotbox.com │   │ rapidtriage.me│
│  (AI Platform)│   │  (No-Code Bot)│   │  (AI Triage)  │
└───────┬───────┘   └───────┬───────┘   └───────┬───────┘
        │                   │                   │
        └───────────────────┼───────────────────┘
                            │
                    ┌───────┴───────┐
                    │   sdods.com   │
                    │  (OSS Core)   │
                    └───────────────┘
```

### How SDODS Powers Products

| Module | Used By | Purpose |
|--------|---------|---------|
| `@sdods/auth` | All products | Authentication |
| `@sdods/rbac` | yarlis.ai, mybotbox | Role-based access |
| `@sdods/ui` | All products | Shared components |
| `@sdods/observability` | All products | Logging, metrics |
| `@sdods/billing` | yarlis.com, mybotbox | Stripe integration |

### Open Core Approach

| Layer | License | Purpose |
|-------|---------|---------|
| **SDODS Core** | MIT | Community adoption |
| **Platform Modules** | Apache 2.0 | Enterprise features |
| **SaaS Products** | Proprietary | Revenue generation |

---

## 📋 Rules of the Road

### Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Portfolio | `yarlis-portfolio` | This repo |
| Product | `{domain-slug}` | `mybotbox`, `rapidtriage` |
| Platform | `sdods-{module}` | `sdods-auth`, `sdods-ui` |
| Monorepo | `yarlis-platform` | Main codebase |

### Branching Model

```
main        ─────●─────●─────●─────●─────►  Production
                 │     │     │
develop     ─────●─────●─────●─────────►    Integration
             │   │     │     │
feature/*   ─●───┘     │     │              Short-lived
hotfix/*    ───────────●─────┘              Emergency
release/*   ─────────────────●──────►       Staged
```

### Repo Creation Checklist

- [ ] Check naming convention
- [ ] Create from template (`templates/product-repo-template.md`)
- [ ] Add to `portfolio/repos.yaml`
- [ ] Set up CI/CD from standards
- [ ] Configure branch protection
- [ ] Add CODEOWNERS
- [ ] Update this README table

---

## 🗂️ Repository Structure

```
yarlis-portfolio/
├── README.md                 # This file
├── portfolio/
│   ├── domains.yaml         # Domain registry
│   ├── products.yaml        # Product details
│   └── repos.yaml           # Repository index
├── templates/
│   ├── product-repo-template.md
│   ├── README-product.md
│   └── INTAKE.md            # New product intake
├── docs/
│   ├── architecture.md
│   ├── naming-conventions.md
│   └── ci-cd-standards.md
└── .github/
    └── workflows/
        └── validate.yml     # Schema validation
```

---

## 🔗 Quick Links

### Products
- [yarlis.com](https://yarlis.com) — Parent company
- [yarlis.ai](https://yarlis.ai) — AI platform
- [mybotbox.com](https://mybotbox.com) — No-code bots
- [rapidtriage.me](https://rapidtriage.me) — AI triage

### Documentation
- [Architecture](docs/architecture.md)
- [Naming Conventions](docs/naming-conventions.md)
- [CI/CD Standards](docs/ci-cd-standards.md)

### Repositories
- [yarlis-platform](https://github.com/siri1410/yarlis-platform) — Main monorepo
- [mybotbox-platform](https://github.com/siri1410/mybotbox-platform) — MyBotBox
- [smartrapidtriage](https://github.com/siri1410/smartrapidtriage) — RapidTriage
- [uip](https://github.com/siri1410/uip) — Unified Identity Platform

---

## 📈 Metrics

| Metric | Value | Updated |
|--------|-------|---------|
| Active Products | 6 | 2026-02-14 |
| Total Repos | 4 | 2026-02-14 |
| Monthly Revenue | $0 | Pre-launch |
| Active Users | 0 | Pre-launch |

---

## 👤 Ownership

| Role | Person |
|------|--------|
| Founder/CEO | Siri (Sireesh Yarlagadda) |
| Chief of Execution | SamJr 🦊 (AI) |
| QA Lead | Dolly 🎀 (AI) |

---

*Last updated: 2026-02-14 | Managed by SamJr 🦊*
