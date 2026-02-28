# @sdods Integration Map — Yarlis Ecosystem

## What's available vs what's wired

| Package | rapidtriage.me | mybotbox.com | yarlis.com | yarlis.ai | sdods.com |
|---------|---------------|--------------|------------|-----------|-----------|
| `@sdods/core` | ⏳ Pending | ⏳ Pending | ⏳ Pending | ✅ Via contracts | — |
| `@sdods/auth` | ⏳ **Priority 1** | ⏳ **Priority 1** | ✅ IS the auth | ➖ N/A | ➖ N/A |
| `@sdods/ui` | ⏳ Pending | ⏳ Pending | ⏳ Pending | ➖ N/A | — |
| `@sdods/themes` | ⏳ Pending | ⏳ Pending | ⏳ Pending | ➖ N/A | — |
| `@sdods/payments` | ⏳ Pending | ⏳ **Priority 1** | ✅ Central billing | ➖ N/A | ➖ N/A |
| `@sdods/observability` | ⏳ Pending | ⏳ Pending | ⏳ Pending | ⏳ **Priority 1** | ➖ N/A |
| `@sdods/comms` | ⏳ Pending | ⏳ Pending | ⏳ Pending | ⏳ Pending | ➖ N/A |
| `@sdods/marketing` | ⏳ Pending | ⏳ Pending | ⏳ Pending | ➖ N/A | — |

## Priority Order (Month 1)
1. `@sdods/auth` → rapidtriage.me + mybotbox (replace ad-hoc Firebase auth)
2. `@sdods/payments` → mybotbox (Stripe checkout)
3. `@sdods/observability` → @yarlisai/router (token cost tracing)
4. `@sdods/themes` → all frontends (brand token system)
5. `@sdods/comms` → all apps (email + Telegram notifications)

## Already Leveraged in CI/CD
- **@sdods/comms pattern** → Telegram notification step in `_pipeline.yml`
  (will switch to proper `@sdods/comms` API once wired)
- **@yarlisai/contracts** → YPID + AppIdentity types used in `app-id.ts`
- **@yarlisai/router** → planned for mybotbox chatbot routing
