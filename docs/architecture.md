# 🏗️ Architecture Overview

> System architecture for the Yarlis portfolio ecosystem

---

## High-Level Architecture

```
                         ┌──────────────────────────────────┐
                         │         CLOUDFLARE CDN           │
                         │    (DNS, WAF, DDoS, Caching)     │
                         └──────────────────┬───────────────┘
                                            │
                    ┌───────────────────────┼───────────────────────┐
                    │                       │                       │
                    ▼                       ▼                       ▼
            ┌───────────────┐       ┌───────────────┐       ┌───────────────┐
            │   yarlis.com  │       │   yarlis.ai   │       │ mybotbox.com  │
            │  (Parent HQ)  │       │ (AI Platform) │       │  (No-Code)    │
            └───────┬───────┘       └───────┬───────┘       └───────┬───────┘
                    │                       │                       │
                    └───────────────────────┼───────────────────────┘
                                            │
                                            ▼
                              ┌─────────────────────────┐
                              │    UIP (Identity)       │
                              │  Multi-tenant Auth      │
                              └────────────┬────────────┘
                                           │
                    ┌──────────────────────┼──────────────────────┐
                    │                      │                      │
                    ▼                      ▼                      ▼
            ┌───────────────┐      ┌───────────────┐      ┌───────────────┐
            │   Firestore   │      │   Cloud SQL   │      │     Redis     │
            │   (NoSQL)     │      │ (PostgreSQL)  │      │   (Cache)     │
            └───────────────┘      └───────────────┘      └───────────────┘
```

---

## Domain Architecture

### 1. yarlis.com (Parent)
```
┌─────────────────────────────────────────┐
│              yarlis.com                 │
├─────────────────────────────────────────┤
│  • Brand & Marketing                    │
│  • Enterprise Sales                     │
│  • Unified Auth Gateway                 │
│  • Cross-product Billing                │
│  • Admin Control Plane                  │
└─────────────────────────────────────────┘
```

### 2. yarlis.ai (AI Platform)
```
┌─────────────────────────────────────────┐
│              yarlis.ai                  │
├─────────────────────────────────────────┤
│  • Mission Control Dashboard            │
│  • Agent Orchestration                  │
│  • Multi-model Abstraction              │
│  • Workflow Management                  │
│  • Real-time Activity                   │
└─────────────────────────────────────────┘
```

### 3. mybotbox.com (No-Code)
```
┌─────────────────────────────────────────┐
│            mybotbox.com                 │
├─────────────────────────────────────────┤
│  • Visual Bot Builder                   │
│  • Template Marketplace                 │
│  • Multi-channel Deploy                 │
│  • Analytics Dashboard                  │
│  • Team Collaboration                   │
└─────────────────────────────────────────┘
```

---

## Shared Platform (SDODS)

```
┌─────────────────────────────────────────────────────────────────┐
│                        SDODS Platform                           │
├─────────────┬─────────────┬─────────────┬─────────────┬────────┤
│  @sdods/    │  @sdods/    │  @sdods/    │  @sdods/    │@sdods/ │
│    auth     │    rbac     │     ui      │observability│billing │
├─────────────┼─────────────┼─────────────┼─────────────┼────────┤
│ Firebase    │ Permission  │ Tamagui    │ OpenTelemetry│ Stripe │
│ Auth0       │ Wildcards   │ Components │ Sentry       │ Webhooks│
│ JWT         │ Roles       │ Theming    │ PostHog      │ Portal  │
└─────────────┴─────────────┴─────────────┴─────────────┴────────┘
```

---

## Data Architecture

### Database Strategy

| Data Type | Storage | Reason |
|-----------|---------|--------|
| User profiles | Firestore | Real-time sync |
| Tasks/Activities | Firestore | Real-time updates |
| Auth/Identity | PostgreSQL (UIP) | Complex relations |
| Analytics | ClickHouse | High volume |
| Cache | Redis | Low latency |
| Files | Cloud Storage | Large objects |

### Multi-Tenancy Model

```
┌─────────────────────────────────────────┐
│                Tenant                   │
│  (e.g., Acme Corp)                     │
├─────────────────────────────────────────┤
│  ┌───────────────┐  ┌───────────────┐  │
│  │ Organization  │  │ Organization  │  │
│  │   (Team A)    │  │   (Team B)    │  │
│  ├───────────────┤  ├───────────────┤  │
│  │ User  User    │  │ User  User    │  │
│  └───────────────┘  └───────────────┘  │
└─────────────────────────────────────────┘
```

---

## Security Architecture

### Defense in Depth

```
┌─────────────────────────────────────────┐
│         Layer 1: Edge (Cloudflare)      │
│    • DDoS Protection                    │
│    • WAF Rules                          │
│    • Rate Limiting                      │
├─────────────────────────────────────────┤
│         Layer 2: Application            │
│    • Auth0/Firebase Auth                │
│    • JWT Validation                     │
│    • RBAC Enforcement                   │
├─────────────────────────────────────────┤
│         Layer 3: API                    │
│    • Input Validation                   │
│    • Rate Limiting                      │
│    • Audit Logging                      │
├─────────────────────────────────────────┤
│         Layer 4: Data                   │
│    • Encryption at Rest                 │
│    • Encryption in Transit              │
│    • Field-level Security               │
└─────────────────────────────────────────┘
```

---

## Deployment Architecture

### Environments

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│    Developer    │────▶│     Staging     │────▶│   Production    │
│     (Local)     │     │   (Firebase)    │     │   (Firebase)    │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        │                       │                       │
        ▼                       ▼                       ▼
   localhost:3000       *-staging.web.app        *.com / *.ai
```

### Hosting Matrix

| App | Hosting | CDN | Database |
|-----|---------|-----|----------|
| yarlis.com | Firebase Hosting | Cloudflare | Firestore |
| yarlis.ai | Firebase Hosting | Cloudflare | Firestore |
| mybotbox | Firebase Hosting | Cloudflare | Firestore |
| UIP API | Cloud Run | — | Cloud SQL |
| Workers | Cloudflare Workers | — | KV |

---

## AI Architecture

### Agent Orchestration

```
┌─────────────────────────────────────────────────────────────────┐
│                     Agent Orchestrator                          │
├─────────────┬─────────────┬─────────────┬─────────────┬────────┤
│   SamJr 🦊  │  Dolly 🎀   │   Nick 💻   │  Roopa 🧪   │ Maya 🎨│
│   (Exec)    │   (QA)      │   (Dev)     │   (Test)    │(Design)│
├─────────────┴─────────────┴─────────────┴─────────────┴────────┤
│                       Model Router                              │
├─────────────┬─────────────┬─────────────┬─────────────┬────────┤
│   OpenAI    │  Anthropic  │   Ollama    │   Google    │ Custom │
│   (GPT-4)   │  (Claude)   │   (Local)   │  (Gemini)   │ Models │
└─────────────┴─────────────┴─────────────┴─────────────┴────────┘
```

### Model Selection

| Use Case | Model | Reason |
|----------|-------|--------|
| Chat (cheap) | GPT-3.5 | Cost |
| Complex tasks | Claude Opus | Quality |
| Local testing | Ollama | Free |
| Vision | GPT-4V | Capability |

---

## Integration Points

### Cross-Product

```
yarlis.com ←──── SSO ────→ yarlis.ai
     │                         │
     │                         │
     └──── Billing ────────────┘
                │
                ▼
           mybotbox.com
```

### External Services

| Service | Purpose | Fallback |
|---------|---------|----------|
| Auth0 | Authentication | Firebase Auth |
| Stripe | Payments | — |
| OpenAI | AI | Anthropic, Ollama |
| Twilio | SMS | SendGrid |
| Sentry | Errors | Console logs |

---

*Last updated: 2026-02-14*
