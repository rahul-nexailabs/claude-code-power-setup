#!/usr/bin/env bash
# Blocks: git push --force/-f to main/master
# Input: JSON on stdin. Exit 2 = block. Exit 0 = allow.

INPUT=$(cat)
cmd=$(echo "$INPUT" | tr -d '\r' | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null || echo "$INPUT" | tr -d '\r' | python -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)

if [[ "$cmd" =~ git[[:space:]]+push.*(--force|-f) ]] && [[ "$cmd" =~ (main|master)($|[[:space:]]) ]]; then
  echo "Blocked: force push to main/master not allowed." >&2
  exit 2
fi
exit 0
