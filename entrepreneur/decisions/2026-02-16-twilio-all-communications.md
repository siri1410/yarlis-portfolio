# Decision: Twilio for All Communications

> Date: 2026-02-16 | Status: Approved | Version: 1.0

---

## Context

MyBotBox needs email and SMS capabilities for:
- User verification (OTP/2FA)
- Transactional emails (welcome, receipts, password reset)
- SMS notifications
- Future: Marketing emails

---

## Decision

**Use Twilio ecosystem for ALL communications:**
- **Twilio Verify** → OTP/2FA (SMS + Email codes)
- **Twilio SendGrid** → All emails (transactional + marketing)
- **Twilio Messaging** → SMS notifications

**Remove Mailchimp** — not needed.

---

## Rationale

### Why All-Twilio?

| Benefit | Impact |
|---------|--------|
| Single vendor | Simpler billing, one contract |
| Unified API | Less code to maintain |
| Shared credentials | Fewer secrets to manage |
| Better analytics | Cross-channel insights |
| Proven scale | Twilio handles billions of messages |

### Why Not Mailchimp?

| Mailchimp | Twilio SendGrid |
|-----------|-----------------|
| Marketing-focused | Transactional + Marketing |
| Separate system | Part of Twilio ecosystem |
| Extra integration | Already using Twilio |
| Additional cost | Included in Twilio pricing |

---

## Implementation

### Services Configured

| Service | Purpose | Status |
|---------|---------|--------|
| Twilio Verify | OTP codes | ✅ VA74e3b5f2c1e99b65d7cb802a568e286e |
| Twilio Messaging | SMS | ✅ +18332735953 |
| SendGrid | Email | ⏳ API key needed |

### Secrets Required

```
TWILIO_ACCOUNT_SID_STAGING ✅
TWILIO_AUTH_TOKEN_STAGING ✅
TWILIO_PHONE_NUMBER_STAGING ✅
TWILIO_VERIFY_SERVICE_SID_STAGING ✅
SENDGRID_API_KEY_STAGING ⏳
```

### Code Locations

```
lib/verification/twilio-verify.ts  → OTP/2FA
lib/email/sendgrid.ts              → Transactional emails
lib/sms/service.ts                 → SMS notifications
```

---

## Email Templates

| Email | Trigger | Template |
|-------|---------|----------|
| Welcome | User signup | `sendWelcomeEmail()` |
| Password Reset | Reset request | `sendPasswordResetEmail()` |
| Invoice | Payment | `sendInvoiceEmail()` |
| Verification | 2FA | Twilio Verify (built-in) |

---

## Cost Estimate

| Service | Volume | Monthly Cost |
|---------|--------|--------------|
| Twilio Verify | 1000 verifications | ~$5 |
| SendGrid | 10,000 emails | Free tier |
| SMS | 500 messages | ~$4 |
| **Total** | | **~$10/month** |

---

## Success Metrics

- Email delivery rate > 98%
- SMS delivery rate > 95%
- OTP verification success > 99%
- Zero Mailchimp dependencies

---

## Approvals

- [x] Siri (Founder) — 2026-02-16

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-16 | Initial decision |
