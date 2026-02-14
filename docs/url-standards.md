# 🔗 URL Standards

> Subdomain vs Path conventions for the Yarlis portfolio.
> Last updated: 2026-02-14

---

## 🎯 Decision Framework

### When to Use SUBDOMAINS

Use subdomains for **separate deployments/services**:

| Subdomain | Purpose | Deployment |
|-----------|---------|------------|
| `@` (root) | Marketing/Landing page | Firebase Hosting |
| `www` | Redirect to root | Firebase Hosting |
| `app` | Main application | Firebase Hosting |
| `api` | REST/GraphQL backend | Cloud Run |
| `docs` | Documentation site | GitHub Pages / MkDocs |
| `auth` | Authentication service | Firebase Auth / Auth0 |
| `staging` | Staging environment | Firebase Hosting |
| `admin` | Internal admin panel | Firebase Hosting |

### When to Use PATHS

Use paths for **routes within the same app**:

| Path | Purpose | Location |
|------|---------|----------|
| `/login` | Sign in page | app.domain.com |
| `/signup` | Create account | app.domain.com |
| `/register` | Alias for signup | app.domain.com |
| `/forgot-password` | Password reset | app.domain.com |
| `/reset-password` | Set new password | app.domain.com |
| `/verify-email` | Email verification | app.domain.com |
| `/dashboard` | Main dashboard | app.domain.com |
| `/settings` | User settings | app.domain.com |
| `/settings/profile` | Profile settings | app.domain.com |
| `/settings/billing` | Billing settings | app.domain.com |
| `/settings/team` | Team management | app.domain.com |
| `/pricing` | Pricing page | root domain |
| `/terms` | Terms of service | root domain |
| `/privacy` | Privacy policy | root domain |
| `/about` | About page | root domain |
| `/contact` | Contact page | root domain |

---

## 📋 Complete URL Matrix

### yarlis.com (Parent Platform)

| URL | Purpose | Status |
|-----|---------|--------|
| `yarlis.com` | Marketing + Research Copilot | ✅ |
| `www.yarlis.com` | Redirect | ✅ |
| `app.yarlis.com` | Application | ✅ |
| `api.yarlis.com` | REST API | ✅ |
| `docs.yarlis.com` | Documentation | ✅ |
| `auth.yarlis.com` | Auth service | ✅ |
| `staging.yarlis.com` | Staging | ✅ |
| `admin.yarlis.com` | Admin panel | ✅ |

**Paths:**
- `yarlis.com/pricing`
- `yarlis.com/terms`
- `yarlis.com/privacy`
- `app.yarlis.com/login`
- `app.yarlis.com/signup`
- `app.yarlis.com/dashboard`
- `app.yarlis.com/settings`

### yarlis.ai (AI Platform)

| URL | Purpose | Status |
|-----|---------|--------|
| `yarlis.ai` | AI Landing | ✅ |
| `www.yarlis.ai` | Redirect | ✅ |
| `app.yarlis.ai` | Mission Control | ✅ |
| `api.yarlis.ai` | AI API | ✅ |
| `docs.yarlis.ai` | AI Docs | ✅ |
| `auth.yarlis.ai` | Auth service | ✅ |
| `staging.yarlis.ai` | Staging | ✅ |
| `admin.yarlis.ai` | Admin panel | ✅ |

**Paths:**
- `app.yarlis.ai/mission-control`
- `app.yarlis.ai/bots`
- `app.yarlis.ai/workflows`
- `app.yarlis.ai/settings`

### mybotbox.com (No-Code Bots)

| URL | Purpose | Status |
|-----|---------|--------|
| `mybotbox.com` | Landing | ✅ |
| `www.mybotbox.com` | Redirect | ✅ |
| `app.mybotbox.com` | Bot Builder | ✅ |
| `api.mybotbox.com` | Bot API | ✅ |
| `docs.mybotbox.com` | Docs | ✅ |
| `auth.mybotbox.com` | Auth | ✅ |
| `staging.mybotbox.com` | Staging | ✅ |
| `admin.mybotbox.com` | Admin | ✅ |

**Paths:**
- `mybotbox.com/pricing`
- `app.mybotbox.com/login`
- `app.mybotbox.com/signup`
- `app.mybotbox.com/dashboard`
- `app.mybotbox.com/bots`
- `app.mybotbox.com/templates`

### sdods.com (Open Source)

| URL | Purpose | Status |
|-----|---------|--------|
| `sdods.com` | Package Landing | ✅ |
| `www.sdods.com` | Redirect | ✅ |
| `docs.sdods.com` | Package Docs | ✅ |
| `api.sdods.com` | Package Registry | ✅ |
| `staging.sdods.com` | Staging | ✅ |

**Paths:**
- `sdods.com/packages`
- `sdods.com/packages/@sdods/core`
- `sdods.com/packages/@sdods/ui`
- `docs.sdods.com/getting-started`
- `docs.sdods.com/api-reference`

### yarlis.io (Developer Tools)

| URL | Purpose | Status |
|-----|---------|--------|
| `yarlis.io` | Dev Portal | ✅ |
| `www.yarlis.io` | Redirect | ✅ |
| `api.yarlis.io` | Dev API | ✅ |
| `docs.yarlis.io` | API Docs | ✅ |
| `staging.yarlis.io` | Staging | ✅ |

**Paths:**
- `yarlis.io/console`
- `yarlis.io/api-keys`
- `docs.yarlis.io/reference`
- `docs.yarlis.io/guides`

### rapidtriage.me (Healthcare AI)

| URL | Purpose | Status |
|-----|---------|--------|
| `rapidtriage.me` | Landing | ✅ |
| `www.rapidtriage.me` | Redirect | ✅ |
| `app.rapidtriage.me` | Triage App | ✅ |
| `api.rapidtriage.me` | Triage API | ✅ |
| `docs.rapidtriage.me` | Docs | ✅ |
| `auth.rapidtriage.me` | Auth | ✅ |
| `staging.rapidtriage.me` | Staging | ✅ |
| `admin.rapidtriage.me` | Admin | ✅ |

**Paths:**
- `app.rapidtriage.me/triage`
- `app.rapidtriage.me/history`
- `app.rapidtriage.me/settings`

---

## 🔐 Auth Flow URLs

### Standard Auth Routes (all products)

```
/login                    → Sign in form
/signup                   → Create account
/logout                   → Sign out (redirect)
/forgot-password          → Request reset email
/reset-password?token=x   → Set new password
/verify-email?token=x     → Confirm email
/oauth/google             → Google OAuth
/oauth/github             → GitHub OAuth
/oauth/callback           → OAuth callback
```

### API Auth Endpoints

```
POST /api/auth/login      → Get JWT
POST /api/auth/register   → Create user
POST /api/auth/refresh    → Refresh token
POST /api/auth/logout     → Invalidate token
POST /api/auth/verify     → Verify email
POST /api/auth/reset      → Password reset
```

---

## 📱 Mobile Deep Links

```
yarlis://login
yarlis://signup
yarlis://dashboard
yarlis://settings
mybotbox://bots
mybotbox://templates
rapidtriage://triage
```

---

## 🚀 Implementation Checklist

### For Each Domain

- [ ] Root domain → Marketing landing
- [ ] www → Redirect to root
- [ ] app → Main application
- [ ] api → Backend API (Cloud Run)
- [ ] docs → Documentation
- [ ] staging → Staging environment
- [ ] Firebase custom domain configured
- [ ] SSL certificate provisioned

### For Each App

- [ ] /login route implemented
- [ ] /signup route implemented
- [ ] /forgot-password route implemented
- [ ] /dashboard route implemented
- [ ] /settings route implemented
- [ ] 404 page configured
- [ ] Redirects configured

---

*Maintained by: SamJr 🦊 | Standard effective: 2026-02-14*
