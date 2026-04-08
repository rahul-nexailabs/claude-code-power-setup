---
name: discuss
description: Capture decisions before planning — locks constraints for downstream agents
argument-hint: <topic>
allowed-tools: Read, Write, Edit
user-invocable: true
---

1. Read STATE.md
2. Identify 2-4 "gray areas" specific to the task type:
   - UI: layout, interactions, responsive behavior
   - API: versioning, error format, auth
   - Content: tone, audience, channels
   - Finance: pricing, payment terms, approval thresholds
3. Ask 1-2 focused questions per area with concrete options
4. Write decisions to CONTEXT.md:
   ## [Topic] — [DATE]
   - [Decision]: [Choice] (LOCKED)
5. Update STATE.md
