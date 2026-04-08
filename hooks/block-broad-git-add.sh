#!/usr/bin/env bash
# Blocks: git add ., git add -A, git add --all, staging .env files
# Input: JSON on stdin. Exit 2 = block. Exit 0 = allow.

INPUT=$(cat)
cmd=$(echo "$INPUT" | tr -d '\r' | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null || echo "$INPUT" | tr -d '\r' | python -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)

if [[ "$cmd" =~ git[[:space:]]+add[[:space:]]+(\.|-A|--all)($|[[:space:]]) ]]; then
  echo "Blocked: stage specific files only." >&2
  exit 2
fi
if [[ "$cmd" =~ git[[:space:]]+add.*\.env ]] && ! [[ "$cmd" =~ \.env\.example ]]; then
  echo "Blocked: never stage .env files (use .env.example for templates)." >&2
  exit 2
fi
exit 0
