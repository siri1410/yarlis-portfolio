# 🧪 Test Data for Each Role

> Standard test accounts and data for E2E testing across the Yarlis portfolio.
> Last updated: 2026-02-14

---

## 👥 Test User Roles

### Role Hierarchy

```
Super Admin (Siri)
    │
    ├── Platform Admin
    │   ├── Product Manager
    │   └── Support Agent
    │
    ├── Organization Admin
    │   ├── Team Lead
    │   └── Team Member
    │
    └── End User (Free/Pro/Enterprise)
```

---

## 🔐 Test Accounts

### Platform Level (All Products)

| Role | Email | Password | MFA | Notes |
|------|-------|----------|-----|-------|
| **Super Admin** | siri@yarlis.com | `Test123!Super` | TOTP | Full access |
| **Platform Admin** | admin@yarlis.com | `Test123!Admin` | TOTP | Manage all orgs |
| **Support Agent** | support@yarlis.com | `Test123!Support` | No | Read-only + tickets |

### Organization Level

| Role | Email | Password | Org | Notes |
|------|-------|----------|-----|-------|
| **Org Admin** | orgadmin@testcorp.com | `Test123!OrgAdmin` | TestCorp | Full org access |
| **Team Lead** | lead@testcorp.com | `Test123!Lead` | TestCorp | Manage team |
| **Team Member** | member@testcorp.com | `Test123!Member` | TestCorp | Basic access |
| **Viewer** | viewer@testcorp.com | `Test123!Viewer` | TestCorp | Read-only |

### End Users

| Plan | Email | Password | Features |
|------|-------|----------|----------|
| **Free** | free@example.com | `Test123!Free` | Basic features |
| **Pro** | pro@example.com | `Test123!Pro` | All features |
| **Enterprise** | enterprise@bigcorp.com | `Test123!Enterprise` | SSO + API |

---

## 🏢 Test Organizations

| Org Name | Org ID | Plan | Users | Products |
|----------|--------|------|-------|----------|
| **TestCorp** | `org_testcorp` | Enterprise | 5 | All |
| **SmallBiz** | `org_smallbiz` | Pro | 2 | MyBotBox |
| **FreeTier** | `org_freetier` | Free | 1 | Limited |

---

## 📦 Product-Specific Test Data

### yarlis.com (Research Copilot)

| Test Case | Input | Expected |
|-----------|-------|----------|
| Market Research | "AI automation market 2026" | Report with sections |
| Competitor Analysis | "n8n vs Zapier" | Comparison table |
| Trend Report | "No-code trends" | Trend insights |

### yarlis.ai (Mission Control)

| Test Case | User | Action | Expected |
|-----------|------|--------|----------|
| Create Task | Org Admin | POST /api/tasks | Task created |
| Move Task | Team Member | PATCH /api/tasks/:id | Status updated |
| View Dashboard | Viewer | GET /mission-control | Read-only view |

### mybotbox.com (Workflow Builder)

| Test Case | User | Workflow | Expected |
|-----------|------|----------|----------|
| Create Bot | Pro | Telegram echo bot | Bot responds |
| Deploy Workflow | Enterprise | n8n webhook | 200 OK |
| View Templates | Free | GET /templates | Limited list |

### rapidtriage.me (AI Triage)

| Test Case | Patient Data | Expected Triage |
|-----------|--------------|-----------------|
| Emergency | Chest pain, SOB | 🔴 Immediate |
| Urgent | Fever 103°F | 🟠 Urgent |
| Standard | Mild headache | 🟢 Standard |

---

## 🔑 API Test Keys

### Staging Environment

| Product | API Key | Rate Limit |
|---------|---------|------------|
| yarlis.com | `yk_test_yarlis_staging_xxx` | 100/min |
| yarlis.ai | `yk_test_ai_staging_xxx` | 50/min |
| mybotbox.com | `yk_test_mbb_staging_xxx` | 200/min |

### Production (Test Mode)

| Product | API Key | Rate Limit |
|---------|---------|------------|
| yarlis.com | `yk_live_test_xxx` | 10/min |
| yarlis.ai | `yk_live_test_xxx` | 10/min |

---

## 🧪 E2E Test Scenarios

### Scenario 1: New User Signup → First Bot

```gherkin
Given I am a new user
When I sign up with "newuser@test.com"
And I verify my email
And I create my first bot
Then I should see the bot in my dashboard
And I should receive a welcome email
```

### Scenario 2: Org Admin Invites Team

```gherkin
Given I am an Org Admin for "TestCorp"
When I invite "newmember@testcorp.com" as Team Member
Then they should receive an invitation email
And they should appear in pending invitations
When they accept the invitation
Then they should have Team Member permissions
```

### Scenario 3: Pro User Upgrades to Enterprise

```gherkin
Given I am a Pro user
When I upgrade to Enterprise plan
And I enter payment details
Then my plan should update to Enterprise
And I should have access to SSO settings
And I should receive an invoice email
```

---

## 📊 Test Data Seeds

### Database Seeds

```sql
-- Organizations
INSERT INTO organizations (id, name, plan) VALUES
  ('org_testcorp', 'TestCorp', 'enterprise'),
  ('org_smallbiz', 'SmallBiz', 'pro'),
  ('org_freetier', 'FreeTier', 'free');

-- Users (passwords are hashed)
INSERT INTO users (email, org_id, role) VALUES
  ('orgadmin@testcorp.com', 'org_testcorp', 'org_admin'),
  ('lead@testcorp.com', 'org_testcorp', 'team_lead'),
  ('member@testcorp.com', 'org_testcorp', 'team_member');
```

### Firestore Seeds (JSON)

```json
{
  "organizations/org_testcorp": {
    "name": "TestCorp",
    "plan": "enterprise",
    "createdAt": "2026-01-01T00:00:00Z"
  },
  "users/orgadmin@testcorp.com": {
    "orgId": "org_testcorp",
    "role": "org_admin",
    "displayName": "Test Org Admin"
  }
}
```

---

## 🔄 Reset Test Data

### Staging Reset Script

```bash
# Reset staging test data
./scripts/reset-test-data.sh staging

# Seed fresh test data
./scripts/seed-test-data.sh staging
```

### Before E2E Tests

```bash
# Run before Playwright tests
npm run test:reset
npm run test:seed
npm run test:e2e
```

---

## 📝 Notes

1. **Never use test credentials in production**
2. **Rotate test API keys monthly**
3. **Test data is reset nightly at 3 AM ET**
4. **Report issues to QA Lead (Dolly 🎀)**

---

*Maintained by: Dolly 🎀 | Approved by: SamJr 🦊*
