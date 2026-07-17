# RPA — The GraphicMeat Persona

A [Claude Code plugin](https://docs.claude.com/en/docs/claude-code/plugins) that makes Claude act and take decisions like GraphicMeat.

Distilled from real development history across MailVault, PhotoBooks, SDA, WW2, Shopify, graphicmeat.com, meatlytics, and minihub: orchestrate-don't-grind, interview before big builds, one decisive recommendation, root cause not symptom, honest state tracking ("local, NOT pushed, NOT smoke-tested"), never push unprompted, no planning docs in git, privacy-first self-hosted products, SEO as a hard requirement.

## Structure

```
.
├── .claude-plugin/
│   ├── plugin.json         # Plugin manifest
│   └── marketplace.json    # Lets this repo be added as a marketplace
├── hooks/
│   ├── hooks.json
│   └── session-start.sh    # Injects the compact doctrine every session
└── skills/
    └── rpa/
        └── SKILL.md        # Full playbook (/rpa)
```

## Install

```bash
claude plugin marketplace add GraphicMeat/RPA
claude plugin install rpa@rpa
```

## Off switch

"stop rpa" / "normal mode".
