# 🎨 Yarlis Brand Guide

> Consistent visual identity across all Yarlis ecosystem products.

---

## Brand Architecture

| Level | Entity | Role |
|-------|--------|------|
| **Parent** | Yarlis | Holding brand — identity, trust, enterprise |
| **Flagship** | MyBotBox | Revenue engine — consumer-facing SaaS |
| **Vertical** | SmartRapidTriage | Niche product — software triage |
| **Platform** | SDODS | Open-core — developer tooling |

---

## Color System

### MyBotBox (Primary Product)

| Token | Hex | Usage |
|-------|-----|-------|
| `brand-primary` | `#FF6B35` | CTAs, primary buttons, links, logo |
| `brand-primary-hover` | `#FF8255` | Hover states |
| `brand-accent` | `#00D4AA` | Secondary actions, success states, highlights |
| `brand-accent-hover` | `#00E6BB` | Hover states |
| `brand-background` | `#FFFFFF` (light) / `#0C0C0C` (dark) | Page background |
| `foreground` | `#1C1C1C` (light) / `#FAFAFA` (dark) | Body text |
| `muted` | `#F5F5F5` (light) / `#1A1A1A` (dark) | Cards, secondary surfaces |
| `border` | `#E5E5E5` (light) / `#2A2A2A` (dark) | Dividers, inputs |

### Yarlis (Parent Brand)

| Token | Hex | Usage |
|-------|-----|-------|
| `yarlis-primary` | `#6B3FFA` | Brand purple — corporate, trust |
| `yarlis-secondary` | `#FF6B35` | Shared orange — ecosystem link |
| `yarlis-accent` | `#00D4AA` | Shared teal |

### SmartRapidTriage

| Token | Hex | Usage |
|-------|-----|-------|
| `srt-primary` | `#2563EB` | Blue — trust, reliability, enterprise |
| `srt-accent` | `#10B981` | Green — success, triage resolution |

### SDODS

| Token | Hex | Usage |
|-------|-----|-------|
| `sdods-primary` | `#8B5CF6` | Purple — developer-friendly |
| `sdods-accent` | `#F59E0B` | Amber — open-source warmth |

---

## Typography

| Usage | Font | Weight | Size |
|-------|------|--------|------|
| Headings | Inter / System UI | 700 (Bold) | 24-48px |
| Body | Inter / System UI | 400 (Regular) | 14-16px |
| Code | JetBrains Mono / Menlo | 400 | 13-14px |
| Landing hero | Soehne (MyBotBox) | 700 | 48-64px |

---

## Logo Usage

### MyBotBox Logo

- **Icon**: Orange rounded square with bot connection motif
- **Wordmark**: "MyBotBox" in bold sans-serif
- **Minimum size**: 24px height
- **Clear space**: 1x icon width on all sides
- **Variants**: `mybotbox-dark.svg` (light bg), `mybotbox-light.svg` (dark bg), `b&w/text/b&w.svg` (monochrome)

### Do Not

- ❌ Stretch or distort the logo
- ❌ Use old red/green colors (#F05A4A, #35D07F)
- ❌ Place on busy backgrounds without contrast
- ❌ Mix brand colors between products

---

## CSS Implementation

```css
/* MyBotBox Brand Variables */
:root {
  --brand-primary-hex: #FF6B35;
  --brand-primary-hover-hex: #FF8255;
  --brand-accent-hex: #00D4AA;
  --brand-accent-hover-hex: #00E6BB;
  --brand-background-hex: #FFFFFF;
}

.dark {
  --brand-primary-hex: #FF6B35;
  --brand-primary-hover-hex: #FF8255;
  --brand-accent-hex: #00D4AA;
  --brand-accent-hover-hex: #00E6BB;
  --brand-background-hex: #0C0C0C;
}
```

---

## Figma & Notion Links

| Resource | URL | Content |
|----------|-----|---------|
| **MyBotBox Design System** | [Figma →](https://figma.com) | Components, pages, brand assets |
| **MyBotBox PRD** | [Notion →](https://notion.so) | Product requirements, roadmap |
| **SRT Design System** | [Figma →](https://figma.com) | SRT components and flows |
| **SRT PRD** | [Notion →](https://notion.so) | SRT product requirements |
| **Yarlis Architecture** | [Notion →](https://notion.so) | System architecture, decisions |

> ⚠️ **TODO**: Replace placeholder URLs with actual Figma/Notion links. Run `grep -rn "figma.com\|notion.so" brand/` to find and update.

