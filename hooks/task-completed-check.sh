#!/usr/bin/env bash
# Verify task completion: require deliverable + TASKS.md update
# Exit 2 = block completion, Exit 0 = allow
INPUT=$(cat)
echo "Before marking complete: 1) Confirm deliverable exists, 2) TASKS.md updated with (claude, DATE)." >&2
exit 0
