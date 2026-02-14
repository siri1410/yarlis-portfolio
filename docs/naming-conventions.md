# 📝 Naming Conventions

> Consistent naming across the Yarlis ecosystem

---

## Repository Naming

| Type | Pattern | Example |
|------|---------|---------|
| Portfolio | `yarlis-portfolio` | This repo |
| Monorepo | `yarlis-platform` | Main codebase |
| Product | `{domain-slug}` | `mybotbox`, `rapidtriage` |
| Platform Module | `sdods-{module}` | `sdods-auth`, `sdods-ui` |
| Internal Tool | `yarlis-{tool}` | `yarlis-cli` |

### Examples
```
✅ Good:
- yarlis-platform
- mybotbox
- rapidtriage
- sdods-auth
- sdods-ui

❌ Bad:
- MyBotBox (no caps)
- rapid-triage-me (too long)
- auth-module (missing sdods prefix)
```

---

## Package Naming

| Type | Pattern | Example |
|------|---------|---------|
| Product Package | `@yarlis/{app}` | `@yarlis/yarlis-ai` |
| Shared Package | `@yarlis/{package}` | `@yarlis/ui`, `@yarlis/auth` |
| SDODS Module | `@sdods/{module}` | `@sdods/auth`, `@sdods/rbac` |

### Package.json Example
```json
{
  "name": "@yarlis/ui",
  "version": "1.0.0"
}
```

---

## Infrastructure Naming

### GCP Resources
```
{company}-{product}-{environment}-{resource}

Examples:
- yarlis-platform-staging-firestore
- yarlis-mybotbox-prod-cloudrun
- yarlis-uip-staging-cloudsql
```

### Firebase Projects
```
{product}-{environment}

Examples:
- yarlis-platform (staging default)
- yarlis-ai (production)
- mybotbox-prod
```

### Secret Manager
```
{prefix}-{environment}-{secret-name}

Examples:
- yarlis-staging-database-url
- yarlis-prod-stripe-secret-key
- yarlis-staging-openai-api-key
```

---

## Branch Naming

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/{ticket}-{description}` | `feature/YARS-123-add-login` |
| Bugfix | `bugfix/{ticket}-{description}` | `bugfix/YARS-456-fix-auth` |
| Hotfix | `hotfix/{description}` | `hotfix/critical-security-fix` |
| Release | `release/v{version}` | `release/v1.2.0` |

### Examples
```
✅ Good:
- feature/YARS-123-add-oauth
- bugfix/YARS-456-fix-login-redirect
- release/v2.0.0

❌ Bad:
- add-oauth (missing prefix)
- feature/add_oauth (use hyphens)
- Feature/YARS-123 (lowercase)
```

---

## Environment Variables

| Type | Pattern | Example |
|------|---------|---------|
| Public (client) | `NEXT_PUBLIC_{NAME}` | `NEXT_PUBLIC_FIREBASE_API_KEY` |
| Private (server) | `{SERVICE}_{NAME}` | `OPENAI_API_KEY` |
| Feature Flag | `FEATURE_{NAME}` | `FEATURE_BILLING` |

### Examples
```bash
# Public (exposed to client)
NEXT_PUBLIC_FIREBASE_API_KEY=xxx
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=pk_xxx

# Private (server only)
DATABASE_URL=postgresql://...
OPENAI_API_KEY=sk-xxx
STRIPE_SECRET_KEY=sk_xxx

# Feature flags
FEATURE_AI_AGENTS=true
FEATURE_BILLING=false
```

---

## Database Naming

### Tables/Collections
```
{entity}s (plural, lowercase, snake_case)

Examples:
- users
- organizations
- tasks
- audit_logs
```

### Columns/Fields
```
{name} (lowercase, snake_case)

Examples:
- id
- created_at
- updated_at
- user_id
- organization_id
```

### Indexes
```
idx_{table}_{columns}

Examples:
- idx_users_email
- idx_tasks_status_created_at
```

---

## API Endpoints

### REST
```
/{resource}s/{id}/{sub-resource}

Examples:
- GET /users
- GET /users/123
- GET /users/123/tasks
- POST /organizations/456/invites
```

### Naming Rules
- Use plural nouns (`/users` not `/user`)
- Use lowercase with hyphens (`/audit-logs` not `/auditLogs`)
- Use query params for filtering (`/users?status=active`)

---

## CSS/Component Naming

### Tailwind Classes
Use utility classes directly, no custom naming needed.

### Component Files
```
{ComponentName}.tsx (PascalCase)

Examples:
- Button.tsx
- TaskCard.tsx
- MissionControlLayout.tsx
```

### CSS Modules (if used)
```
{component}.module.css

Examples:
- Button.module.css
- TaskCard.module.css
```

---

## Commit Messages

### Format
```
{type}({scope}): {description}

[optional body]
[optional footer]
```

### Types
- `feat` — New feature
- `fix` — Bug fix
- `docs` — Documentation
- `style` — Formatting
- `refactor` — Code restructure
- `test` — Tests
- `chore` — Maintenance

### Examples
```
✅ Good:
- feat(auth): add OAuth login flow
- fix(ui): correct button alignment
- docs(readme): update installation guide

❌ Bad:
- Added OAuth (missing type)
- feat: stuff (vague description)
- FEAT(AUTH): ADD OAUTH (no caps)
```

---

*Last updated: 2026-02-14*
