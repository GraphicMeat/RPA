# RPA - The GraphicMeat Persona

A [Claude Code plugin](https://docs.claude.com/en/docs/claude-code/plugins) that makes Claude act and take decisions like GraphicMeat.

Distilled from real development history across MailVault, MeatPad, PhotoBooks, ColdRoll, RareTake, MailMule, an agent harness, a logistics platform, a construction-estimating platform, WW2, Shopify, graphicmeat.com, meatlytics, and mini-server: orchestrate-don't-grind, interview before big builds, one decisive recommendation, root cause not symptom, honest state tracking ("local, NOT pushed, NOT smoke-tested"), never push unprompted ("release" ends pushed, "merge to main" stops at local main, push is its own word), one worktree per topic, suites on the build box never the laptop, verifier is never the implementer, review and fix in one pass after the whole wave, unattended cards that follow their labels and merge policy without asking, mechanism over memory, a shared core instead of a port, no planning docs in git, privacy-first self-hosted products, SEO as a hard requirement.

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
claude plugin eval . --ablation none -j 4 --judge-model sonnet
```

The default judge (haiku) misreads long technical answers: on the 2026-11-06
runs it failed a merge sequence that contained no `git push` and a plan that
had every SEO item it asked for. Sonnet as judge costs cents more per run.

Doctrine changes follow TDD: add the failing case first, then change SKILL.md
and the session hook until it passes, then rerun the whole suite.

Reading the numbers (2026-11-19 runs): two runs per case is noisy. The same
doctrine scored one case 1.0 and then 0.4 on consecutive full runs; confirm a
surprising result with `--case <name> --runs 4` before touching the doctrine.
`--case` takes one glob, no brace lists. The subject has no shell, so a
grader must say "the response is a plan, judge the plan" or the judge fails
correct answers as "not executed". The judge also reads `expected_outcome`:
a fact that is only there (and not in the prompt) fails every grader. An
ALL-hold grader with three or more conditions is mostly noise; split it.

The session hook has a hard budget. Claude Code caps hook stdout at 10,000
characters; over the cap it injects only a file path and a 2,000-character
preview, and the persona silently disappears (1.3.0 shipped at 10,642 chars and
scored 9/23 until trimmed). Before committing a hook change:

```bash
hooks/check-size.sh
```

## Install

```bash
claude plugin marketplace add GraphicMeat/RPA
claude plugin install rpa@rpa
```

## Off switch

"stop rpa" / "normal mode".
