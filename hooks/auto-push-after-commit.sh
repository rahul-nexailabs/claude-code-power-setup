#!/usr/bin/env bash
# Auto-pushes to remote after a successful git commit.
# Input: PostToolUse JSON on stdin. Exit 0 = no-op (informational hook).

INPUT=$(cat)
cmd=$(echo "$INPUT" | tr -d '\r' | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null || echo "$INPUT" | tr -d '\r' | python -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)

# Only trigger on git commit commands (not amend-only, not revert, etc.)
if [[ "$cmd" =~ git[[:space:]]+commit ]] && ! [[ "$cmd" =~ --amend[[:space:]]*$ ]]; then
  # Check if there's a remote tracking branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  remote=$(git config --get "branch.${branch}.remote" 2>/dev/null)
  if [[ -n "$remote" ]]; then
    git push "$remote" "$branch" 2>/dev/null &
  fi
fi
exit 0
