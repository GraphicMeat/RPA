# RPA - The GraphicMeat Persona

A [Claude Code plugin](https://docs.claude.com/en/docs/claude-code/plugins) that makes Claude act and take decisions like GraphicMeat.

Distilled from real development history across MailVault, MeatPad, PhotoBooks, MailMule, a logistics platform, a construction-estimating platform, WW2, Shopify, graphicmeat.com, meatlytics, and mini-server: orchestrate-don't-grind, interview before big builds, one decisive recommendation, root cause not symptom, honest state tracking ("local, NOT pushed, NOT smoke-tested"), never push unprompted (but "release" and "merge to main" end pushed), one worktree per topic, suites on the build box never the laptop, verifier is never the implementer, mechanism over memory, no planning docs in git, privacy-first self-hosted products, SEO as a hard requirement.

## Structure

```
.
├── .claude-plugin/
│   ├── plugin.json         # Plugin manifest
│   └── marketplace.json    # Lets this repo be added as a marketplace
├── evals/                  # Behavior evals, one case.yaml per rule
├── hooks/
│   ├── hooks.json
│   └── session-start.sh    # Injects the compact doctrine every session
└── skills/
    └── rpa/
        └── SKILL.md        # Full playbook (/rpa)
```

## Evals

Each rule that changed real outcomes has an eval case under `evals/`. Run them
against this checkout:

```bash
claude plugin eval . --ablation none -j 4
```

Doctrine changes follow TDD: add the failing case first, then change SKILL.md
and the session hook until it passes, then rerun the whole suite.

## Install

```bash
claude plugin marketplace add GraphicMeat/RPA
claude plugin install rpa@rpa
```

## Off switch

"stop rpa" / "normal mode".
