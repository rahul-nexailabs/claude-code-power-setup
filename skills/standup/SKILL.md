---
name: standup
description: Morning briefing across all departments
allowed-tools: Read, Glob, Grep, Bash
user-invocable: true
disable-model-invocation: true
context: fork
agent: Explore
---

1. Read TASKS.md (all tasks, grouped by @dept: tags)
2. Read context/NOW.md (current business state)
3. List high-priority tasks, blocked items with reasons, recent completions — grouped by department
4. Check git activity across project repos (last 24h)
5. Output concise briefing: moving, stuck, needs attention
