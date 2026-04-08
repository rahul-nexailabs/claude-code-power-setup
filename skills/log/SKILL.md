---
name: log
description: Log daily update and refresh NOW.md
allowed-tools: Read, Edit, Write
user-invocable: true
disable-model-invocation: true
---

1. Ask user for today's update (or accept from argument)
2. Find current month file in Log/ (format: YYYY-MM.md)
   - Create if missing, with # Month Year header
3. Append entry:
   ## YYYY-MM-DD
   **Key Metrics**: [numbers]
   **Pipeline**: [deal movement]
   **Activity**: [what happened]
   **Blocker**: [if any]
   **Tomorrow**: [next action]
4. Read context/NOW.md
5. Update NOW.md to reflect changes
6. Confirm what was written to both files
