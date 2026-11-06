#!/bin/bash
# Claude Code caps a hook's stdout at 10,000 characters. Over the cap it saves
# the text to a file and injects only the path plus a 2,000-character preview,
# and an eval sandbox grants no Read tool, so the persona silently vanishes.
# RPA 1.3.0 shipped at 10,642 and scored 9/23 against 13/15 for 1.2.0.
# Run before committing a hook change: exits 1 when over budget.
set -euo pipefail
LIMIT=9500
HOOK="$(dirname "$0")/session-start.sh"
chars=$(bash "$HOOK" | wc -m | tr -d ' ')
echo "session-start.sh emits $chars chars (budget $LIMIT, hard cap 10000)"
if [ "$chars" -ge "$LIMIT" ]; then
  echo "OVER BUDGET: trim the hook or move text to skills/rpa/SKILL.md" >&2
  exit 1
fi
