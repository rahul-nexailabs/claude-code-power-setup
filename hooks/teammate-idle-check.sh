#!/usr/bin/env bash
# If teammate goes idle, check if they still have uncompleted tasks
# Exit 2 = keep working, Exit 0 = allow idle
INPUT=$(cat)
echo "Check your TASKS.md -- are all assigned tasks marked complete? If not, continue working." >&2
exit 2
