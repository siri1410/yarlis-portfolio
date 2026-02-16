# Decision: Hybrid Pricing Model

> Date: 2026-02-16 | Status: Approved | Version: 1.0

---

## Context

MyBotBox needs a pricing strategy that:
1. Generates recurring revenue (MRR)
2. Captures AI usage value
3. Is transparent to users
4. Provides healthy margins

---

## Decision

**Adopt a hybrid pricing model:**
- Base subscription for platform features
- Pay-as-you-go AI token usage with markup

---

## Rationale

### Why Not Pure Subscription?

| Issue | Impact |
|-------|--------|
| Heavy AI users underpay | Lost revenue |
| Light users overpay | Churn risk |
| Unpredictable costs for us | Margin pressure |

### Why Not Pure Usage?

| Issue | Impact |
|-------|--------|
| Unpredictable for users | Adoption friction |
| No recurring base | Cash flow volatility |
| Commodity pricing | Race to bottom |

### Why Hybrid Works

| Benefit | How |
|---------|-----|
| Predictable base MRR | Subscription |
| Fair AI pricing | Token markup |
| Industry standard | Users trained by OpenAI |
| Healthy margins | 20-30% on tokens |

---

## Implementation

### Phase 1 (Now)
- Keep existing tiers (Free/Pro/Team/Enterprise)
- Add $10 free AI credit for Free tier
- Display token usage in dashboard

### Phase 2 (Q2)
- Add AI usage graphs
- Implement usage alerts
- Auto-upgrade prompts

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Conversion (free→paid) | >10% |
| ARPU | >$30 |
| Token margin | 25% |
| Churn | <5% |

---

## Alternatives Considered

1. **Flat pricing only** — Rejected (leaves money on table)
2. **Usage only** — Rejected (too unpredictable)
3. **Credit packs** — Considered for future

---

## Risks

| Risk | Mitigation |
|------|------------|
| Users confused by tokens | Clear docs + UI |
| AI costs spike | Set margin buffer |
| Competitors undercut | Differentiate on features |

---

## Approvals

- [x] Siri (Founder) — 2026-02-16

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-16 | Initial decision |
