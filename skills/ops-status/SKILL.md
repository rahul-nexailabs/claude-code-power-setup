---
name: ops-status
description: Department task dashboard
allowed-tools: Read, Glob, Grep
user-invocable: true
disable-model-invocation: true
---

Read TASKS.md (single file, all departments).
Group tasks by @dept: tag.
Count active (- [ ], non-blocked), completed (- [x]), and blocked (@blocked) per department.
Output summary table. Flag departments with 0 active or >3 blocked.
