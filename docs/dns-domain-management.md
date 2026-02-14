# 🌐 DNS & Domain Management

> Complete DNS configuration and domain strategy for the Yarlis portfolio.
> Last updated: 2026-02-14

---

## 📍 Domain Overview

| Domain | Registrar | DNS Provider | SSL | Email | Status |
|--------|-----------|--------------|-----|-------|--------|
| **yarlis.com** | AWS Route 53 | AWS Route 53 | Firebase | Google Workspace | ✅ Active |
| **yarlis.ai** | Cloudflare | Cloudflare | Cloudflare | Cloudflare Email | ✅ Active |
| **mybotbox.com** | AWS Route 53 | AWS Route 53 | Firebase | — | ✅ Active |
| **sdods.com** | AWS Route 53 | AWS Route 53 | Firebase | — | ✅ Active |
| **yarlis.io** | AWS Route 53 | AWS Route 53 | Firebase | — | ⏳ Propagating |
| **rapidtriage.me** | Cloudflare | Cloudflare | Cloudflare | — | ✅ Active |

---

## 🎯 Domain Strategy

### Primary Domains

| Domain | Purpose | Target Audience |
|--------|---------|-----------------|
| **yarlis.com** | Parent company, Research Copilot | Enterprise buyers |
| **yarlis.ai** | AI Platform, Mission Control | Developers, Teams |
| **mybotbox.com** | No-code bot builder | SMBs, Solopreneurs |

### Secondary Domains

| Domain | Purpose | Target Audience |
|--------|---------|-----------------|
| **sdods.com** | Open-source packages, Docs | Developers |
| **yarlis.io** | Developer APIs, Tooling | Developers |
| **rapidtriage.me** | Healthcare AI triage | Healthcare providers |

---

## 🔧 DNS Configuration

### yarlis.com (AWS Route 53)

| Record | Type | Value | Purpose |
|--------|------|-------|---------|
| `yarlis.com` | A | 199.36.158.100 | Firebase Hosting |
| `www.yarlis.com` | A | 199.36.158.100 | WWW redirect |
| `staging.yarlis.com` | A | 199.36.158.100 | Staging env |
| `app.yarlis.com` | A | 199.36.158.100 | App subdomain |
| `yarlis.com` | MX | Google Workspace | Email |
| `yarlis.com` | TXT | SPF + Firebase | Email auth |
| `_dmarc.yarlis.com` | TXT | DMARC policy | Email security |

**Hosted Zone ID:** `Z062731035HVA0AFX6R3S`

### yarlis.ai (Cloudflare)

| Record | Type | Value | Proxied | Purpose |
|--------|------|-------|---------|---------|
| `yarlis.ai` | A | 199.36.158.100 | No | Firebase Hosting |
| `www.yarlis.ai` | A | 199.36.158.100 | No | WWW redirect |
| `staging.yarlis.ai` | A | 199.36.158.100 | No | Staging env |
| `yarlis.ai` | MX | Cloudflare Email | — | Email routing |
| `yarlis.ai` | TXT | SPF + DKIM | — | Email auth |

**Zone ID:** `fa13928b50658984761c6cdec6a34511`

### mybotbox.com (AWS Route 53)

| Record | Type | Value | Purpose |
|--------|------|-------|---------|
| `mybotbox.com` | A | 199.36.158.100 | Firebase Hosting |
| `www.mybotbox.com` | A | 199.36.158.100 | WWW redirect |
| `staging.mybotbox.com` | CNAME | ystudio-core.web.app | Staging |

**Hosted Zone ID:** `Z02452542NIWKNF5G9FLD`

### sdods.com (AWS Route 53)

| Record | Type | Value | Purpose |
|--------|------|-------|---------|
| `sdods.com` | A | 199.36.158.100 | Firebase Hosting |
| `www.sdods.com` | A | 199.36.158.100 | WWW redirect |
| `sdods.com` | TXT | Google verification | Site ownership |

**Hosted Zone ID:** `Z04704512KW8HY61QOMEK`

### yarlis.io (AWS Route 53)

| Record | Type | Value | Purpose |
|--------|------|-------|---------|
| `yarlis.io` | A | 199.36.158.100 | Firebase Hosting |
| `www.yarlis.io` | A | 199.36.158.100 | WWW redirect |

**Hosted Zone ID:** `Z07129912OKVJQWI5321`

### rapidtriage.me (Cloudflare)

| Record | Type | Value | Proxied | Purpose |
|--------|------|-------|---------|---------|
| `rapidtriage.me` | AAAA | 100:: | Yes | Cloudflare Pages |
| `www.rapidtriage.me` | AAAA | 100:: | Yes | Cloudflare Pages |
| `docs.rapidtriage.me` | CNAME | GitHub Pages | Yes | Documentation |

**Zone ID:** `dba0cbc72f7f0b7727fbdb6f4d6d7901`

---

## 📧 Email Configuration

### yarlis.com (Google Workspace)

```
MX Records:
1  ASPMX.L.GOOGLE.COM
5  ALT1.ASPMX.L.GOOGLE.COM
5  ALT2.ASPMX.L.GOOGLE.COM
10 ALT3.ASPMX.L.GOOGLE.COM
10 ALT4.ASPMX.L.GOOGLE.COM

SPF: v=spf1 include:_spf.google.com include:_spf.firebasemail.com ~all
DMARC: v=DMARC1; p=quarantine; rua=mailto:dmarc@yarlis.com
```

### yarlis.ai (Cloudflare Email Routing)

```
MX Records:
route1.mx.cloudflare.net
route2.mx.cloudflare.net
route3.mx.cloudflare.net

SPF: v=spf1 include:_spf.mx.cloudflare.net ~all
DKIM: Cloudflare managed (cf2024-1._domainkey)
```

---

## 🏗️ Recommended Subdomain Structure

### Per-Product Convention

```
{product}.{domain}
├── app.{domain}        → Production app
├── staging.{domain}    → Staging environment
├── api.{domain}        → API endpoints (Cloud Run)
├── docs.{domain}       → Documentation (GitHub Pages)
└── admin.{domain}      → Admin panel (internal)
```

### Current Implementation

| Subdomain | yarlis.com | yarlis.ai | mybotbox.com |
|-----------|------------|-----------|--------------|
| `@` (root) | ✅ Firebase | ✅ Firebase | ✅ Firebase |
| `www` | ✅ Firebase | ✅ Firebase | ✅ Firebase |
| `staging` | ✅ Firebase | ✅ Firebase | ✅ ystudio |
| `app` | ✅ Firebase | — | — |
| `api` | — | — | — |
| `docs` | — | — | — |

---

## 🔒 SSL/TLS Strategy

| Provider | Domains | Auto-Renew | Type |
|----------|---------|------------|------|
| **Firebase** | yarlis.com, mybotbox.com, sdods.com, yarlis.io | ✅ Yes | Let's Encrypt |
| **Cloudflare** | yarlis.ai, rapidtriage.me | ✅ Yes | Universal SSL |

---

## 🚀 Adding New Subdomains

### AWS Route 53

```bash
# Add A record
aws route53 change-resource-record-sets \
  --hosted-zone-id Z062731035HVA0AFX6R3S \
  --change-batch '{
    "Changes": [{
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "new.yarlis.com",
        "Type": "A",
        "TTL": 300,
        "ResourceRecords": [{"Value": "199.36.158.100"}]
      }
    }]
  }'
```

### Cloudflare

```bash
# Add A record
curl -X POST "https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  --data '{"type":"A","name":"new","content":"199.36.158.100","ttl":300,"proxied":false}'
```

---

## 📋 Maintenance Checklist

### Monthly
- [ ] Verify SSL certificates are valid
- [ ] Check DNS propagation for all domains
- [ ] Review email deliverability reports
- [ ] Rotate API tokens if needed

### Quarterly
- [ ] Review domain renewals (auto-renew enabled)
- [ ] Audit DNS records for unused entries
- [ ] Test failover configurations
- [ ] Update documentation

---

## 🔗 Quick Reference

### AWS Route 53 Console
https://console.aws.amazon.com/route53/home

### Cloudflare Dashboard
https://dash.cloudflare.com

### Firebase Hosting Console
https://console.firebase.google.com/project/yarlis-platform/hosting

---

*Maintained by: SamJr 🦊 | Last DNS audit: 2026-02-14*
