---
name: verify-work
description: Verify completed work from user's perspective, auto-fix gaps
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
user-invocable: true
---

1. Read STATE.md for current position
2. Read recent deliverables (check git log, find new/modified files)
3. Extract testable behaviors from what was built
4. If deliverable involves server/DB: prepend cold-start smoke test
5. Present one test at a time. User responds in plain text.
6. On failure:
   a. Spawn debug subagent to diagnose root cause
   b. Create fix plan with structured task blocks
   c. Execute fix
   d. Re-verify
7. Persist results to VERIFICATION.md
8. Update STATE.md
