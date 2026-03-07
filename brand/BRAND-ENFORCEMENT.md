# Brand Enforcement Across Yarlis Portfolio

## Products & Their Brand Colors

| Product | Repo | Primary | Accent | Enforcement |
|---------|------|---------|--------|-------------|
| MyBotBox | mybotbox-platform | #FF6B35 | #00D4AA | brand-constants.ts + globals.css + dark mode skill |
| RapidTriage | smartrapidtriage | #2563EB | #10B981 | brand-enforce.css in every HTML page |
| Yarlis | yarlis-platform | #6B3FFA | #FF6B35 | TBD (scaffold) |
| SDODS | sdods | #8B5CF6 | #06B6D4 | TBD (scaffold) |

## Enforcement Mechanisms

### MyBotBox (Next.js / Tailwind)
- Source of truth: `apps/sat/lib/branding/brand-constants.ts`
- CSS vars: `apps/sat/app/globals.css` (`:root` and `.dark`)
- Hook: `.claude/hooks/blocked-dirs.sh` warns on direct hex usage
- Skill: `.claude/skills/brand-guidelines.md` + `dark-mode.md`
- Review: `.claude/skills/code-review.md` includes brand compliance

### SmartRapidTriage (Static HTML)
- Source of truth: `dist/public/brand/brand-enforce.css`
- Every page must `<link>` brand-enforce.css before inline styles
- Hook: warns on banned colors (#00C4D4, #667eea)
- Skill: `.claude/skills/brand-guidelines.md`

### Shared Rules
1. No hardcoded hex for brand colors — use CSS vars or design tokens
2. Each product uses ONLY its own palette (no MBB orange in SRT)
3. Parent brand (Yarlis purple #6B3FFA) in footer only
4. Inter font family across all products
5. Dark backgrounds use Slate scale (900→800→700)

## Visual Hierarchy
Yarlis purple → Product primary → Product accent → Semantic colors → Neutrals
