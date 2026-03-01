# 📚 SDODS

> 🎨 **Figma:** [sdods.com Design](https://www.figma.com/files/team/1541530489515876113/project/557500879)

> **Software Development & Operations Data Systems (Open Source Core)**

---

## Overview

| Field | Value |
|-------|-------|
| **Domain** | sdods.com |
| **Repo** | [sdods](https://github.com/Yarlis/sdods) |
| **Status** | 🟡 Build |
| **Category** | Platform |
| **Monetization** | Open Core |

## Tech Stack

| Layer | Technology |
|-------|------------|
| Language | TypeScript 5.x |
| Build | tsup |
| Package Manager | pnpm (monorepo) |
| Testing | Vitest |
| Linting | ESLint + Prettier |
| CI/CD | GitHub Actions |
| Registry | npm |

## Packages

| Package | Description | Status |
|---------|-------------|--------|
| `@sdods/core` | Core utilities (zero deps) | ✅ Published |
| `@sdods/auth` | Auth abstractions | ✅ Published |
| `@sdods/ui` | React components | ✅ Published |
| `@sdods/observability` | Logging/metrics | ✅ Published |
| `@sdods/billing` | Stripe integration | 🚧 WIP |
| `@sdods/rbac` | Role-based access | 🚧 WIP |

## Installation

```bash
pnpm add @sdods/core @sdods/auth @sdods/ui
```

## Usage

```typescript
import { createAuthProvider } from '@sdods/auth';
import { Button, Card } from '@sdods/ui';
import { Logger } from '@sdods/observability';

const auth = createAuthProvider({ provider: 'auth0' });
const logger = new Logger({ service: 'my-app' });
```

## Open Core Model

| Layer | License | Purpose |
|-------|---------|---------|
| Core packages | MIT | Community adoption |
| Enterprise modules | Apache 2.0 | Advanced features |
| Cloud service | Proprietary | Managed platform |

---

*Last updated: 2026-02-18*
