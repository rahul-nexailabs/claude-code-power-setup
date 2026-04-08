---
name: delegate
description: Add task to TASKS.md
argument-hint: <department> <task>
allowed-tools: Read, Edit
user-invocable: true
disable-model-invocation: true
---

1. Read TASKS.md
2. Determine correct section (Today/Followups/Backlog based on urgency)
3. Append: - [ ] <task> @dept:<tag> @priority:medium @owner:<agent|user> @due:<YYYY-MM-DD if known>
   - Add @blocked-by:"reason" if applicable
   - Add @started:<YYYY-MM-DD> when work begins
4. Confirm and show the section where task was added
