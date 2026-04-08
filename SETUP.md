# Claude Code Power Setup Guide
### By NexAI Labs

> Turn Claude Code from a chatbot into an AI operating system for your business. This guide gives you the exact setup that runs NexAI Labs — hooks, skills, agents, safety rails, and automation.

---

## Prerequisites

- **Claude Code CLI** — Install: `npm install -g @anthropic-ai/claude-code` (requires Node.js 18+)
- **Git** — For version control and hooks
- **Python 3** — Required by hook scripts
- **Anthropic API key** — Get from console.anthropic.com (or use Claude Max subscription)
- **Windows users**: Install Git Bash (comes with Git for Windows) — hooks use bash

## Step 1: First Run & Model Selection

Run `claude` in your terminal. On first launch:
1. Authenticate with your API key or Claude Max account
2. Select model: **Opus 4.6** (recommended for business use — strongest reasoning, 1M context)
3. Run `/powerup` to take the interactive tutorial

## Step 2: Global CLAUDE.md (Your AI's Operating Manual)

Create `~/.claude/CLAUDE.md` — this is the master instruction file Claude reads at the start of every conversation.

Template (customize the placeholders):

```markdown
# {{YOUR_ROLE}} | {{YOUR_COMPANY}}

You are the {{ROLE}} of {{COMPANY}}. {{USER_NAME}} is your human partner.
{{PERSONALITY_INSTRUCTION}}

## Your Job
{{JOB_DESCRIPTION}}

## Goal
{{PRIMARY_GOAL}}

## Thinking
- First principles, not analogy. Question the premise. Invert. Connect across domains.
- Ask questions, 5 whys, critical thinking, out-of-the-box, diverge then converge.

## Non-Negotiables
- For non-trivial work: explore read-only, present a plan, get explicit approval, then execute.
- For trivial edits: execute directly and verify.
- For bugs with clear reproduction: fix it, verify, report.
- Verify before claiming success. State what was checked.

## Working Style
- Explore → Plan → Approve → Implement (small batches) → Verify.
- Smallest change that solves the approved problem. Reuse before reimplementing.
- No phantom features, commands, or architecture.
- 3 attempts max, then stop and ask.

## Self-Improvement
- After ANY correction from the user: update LESSONS.md
- Write rules that prevent the same mistake
- Review lessons at session start

## Context Protocol
- Step 0: Read STATE.md (current position, recent decisions, blockers)
- Step last: Update STATE.md with what was done
- Keep STATE.md under 100 lines — it's a cache, not a log
- Plan tasks use structured blocks with read_first, action, acceptance_criteria, verify
- CONTEXT.md captures locked decisions. Downstream agents treat them as constraints.

## Context Files
- `context/NOW.md` — current business state
- `context/TEAM.md` — team + roles
- `TASKS.md` — all tasks
```

### Why This Structure Works (GSD Hybrid)

This setup borrows from two frameworks:
- **GSD (Get Stuff Done)**: The Discuss → Plan → Execute → Verify cycle, locking decisions before building, fresh context per task
- **Ralph Loop**: Atomic stories with boolean pass/fail, persistent memory in artifacts

We rejected both as-is. GSD's full 6-stage ceremony with XML plans is overkill. Ralph is too permissive. The hybrid gives you spec-driven discipline with lean markdown execution.

**Key principle**: No frameworks to install. No JSON schemas. No XML. Just markdown with phases and checkboxes that any CLI can execute.

## Step 3: Settings.json (The Control Center)

Create or edit `~/.claude/settings.json`:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1",
    "ENABLE_LSP_TOOL": "1"
  },
  "permissions": {
    "deny": [
      "Bash(rm -rf /*)",
      "Bash(cat ~/.ssh/*)",
      "Bash(cat ~/.aws/*)",
      "Read(.env)",
      "Read(.env.*)"
    ]
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "{{HOME_PATH}}/.claude/hooks/block-broad-git-add.sh"
          },
          {
            "type": "command",
            "command": "{{HOME_PATH}}/.claude/hooks/block-force-push.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "{{HOME_PATH}}/.claude/hooks/auto-push-after-commit.sh"
          }
        ]
      }
    ],
    "TeammateIdle": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "{{HOME_PATH}}/.claude/hooks/teammate-idle-check.sh"
          }
        ]
      }
    ],
    "TaskCompleted": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "{{HOME_PATH}}/.claude/hooks/task-completed-check.sh"
          }
        ]
      }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File {{HOME_PATH}}/.claude/statusline.ps1"
  },
  "enabledPlugins": {
    "superpowers@claude-plugins-official": true,
    "context7@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "security-guidance@claude-plugins-official": true
  },
  "effortLevel": "high",
  "autoUpdatesChannel": "latest",
  "voiceEnabled": true,
  "teammateMode": "in-process"
}
```

**Replace `{{HOME_PATH}}`** with your actual home directory path:
- Windows: `C:/Users/YourName`
- Mac: `/Users/YourName`
- Linux: `/home/YourName`

### What Each Setting Does

| Setting | Purpose |
|---------|---------|
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | Enables multi-agent teams (agents that coordinate) |
| `ENABLE_LSP_TOOL` | Language Server Protocol for type checking |
| `permissions.deny` | Blocks dangerous commands (rm -rf, reading SSH keys, reading .env) |
| `hooks.PreToolUse` | Runs BEFORE Claude executes a command (safety checks) |
| `hooks.PostToolUse` | Runs AFTER Claude executes a command (auto-push) |
| `hooks.TeammateIdle` | Pokes idle teammates to keep working |
| `hooks.TaskCompleted` | Verifies deliverables before marking tasks done |
| `effortLevel: "high"` | Claude thinks harder, doesn't cut corners |
| `teammateMode: "in-process"` | Agent teams run in same process (faster) |

## Step 4: Safety Hooks (Copy-Paste Ready)

Create the directory: `mkdir -p ~/.claude/hooks`

### Hook 1: block-force-push.sh
Prevents force-pushing to main/master (protects your production branch).

```bash
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
```

### Hook 2: block-broad-git-add.sh
Prevents `git add .` and staging .env files (avoids accidental secret commits).

```bash
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
```

### Hook 3: auto-push-after-commit.sh
Auto-pushes to remote after every commit (keeps your repo synced).

```bash
#!/usr/bin/env bash
# Auto-pushes to remote after a successful git commit.
# Input: PostToolUse JSON on stdin. Exit 0 = no-op (informational hook).

INPUT=$(cat)
cmd=$(echo "$INPUT" | tr -d '\r' | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null || echo "$INPUT" | tr -d '\r' | python -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)

if [[ "$cmd" =~ git[[:space:]]+commit ]] && ! [[ "$cmd" =~ --amend[[:space:]]*$ ]]; then
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  remote=$(git config --get "branch.${branch}.remote" 2>/dev/null)
  if [[ -n "$remote" ]]; then
    git push "$remote" "$branch" 2>/dev/null &
  fi
fi
exit 0
```

### Hook 4: teammate-idle-check.sh
Prevents agent teammates from going idle when they have unfinished tasks.

```bash
#!/usr/bin/env bash
INPUT=$(cat)
echo "Check your TASKS.md -- are all assigned tasks marked complete? If not, continue working." >&2
exit 2
```

### Hook 5: task-completed-check.sh
Verifies deliverables exist before marking a task complete.

```bash
#!/usr/bin/env bash
INPUT=$(cat)
echo "Before marking complete: 1) Confirm deliverable exists, 2) TASKS.md updated with (claude, DATE)." >&2
exit 0
```

**Make all hooks executable:**
```bash
chmod +x ~/.claude/hooks/*.sh
```

## Step 5: Custom Skills (Slash Commands)

Skills are reusable workflows triggered by `/command`. Create each as a `SKILL.md` file.

### /standup — Morning Briefing
`~/.claude/skills/standup/SKILL.md`
```markdown
---
name: standup
description: Morning briefing across all departments
allowed-tools: Read, Glob, Grep, Bash
user-invocable: true
disable-model-invocation: true
context: fork
agent: Explore
---

1. Read {{WORKSPACE}}/TASKS.md (all tasks, grouped by department/domain)
2. Read {{WORKSPACE}}/context/NOW.md (current business state)
3. List high-priority tasks, blocked items with reasons, recent completions
4. Check git activity across project repos (last 24h)
5. Output concise briefing: moving, stuck, needs attention
```

### /log — Daily Update Logger
`~/.claude/skills/log/SKILL.md`
```markdown
---
name: log
description: Log daily update and refresh NOW.md
allowed-tools: Read, Edit, Write
user-invocable: true
disable-model-invocation: true
---

1. Ask user for today's update (or accept from argument)
2. Find current month file in {{WORKSPACE}}/Log/ (format: YYYY-MM.md)
   - Create if missing, with # Month Year header
3. Append entry with date, key metrics, pipeline, blockers, next action
4. Read {{WORKSPACE}}/context/NOW.md
5. Update NOW.md to reflect changes
6. Confirm what was written to both files
```

### /delegate — Task Assignment
`~/.claude/skills/delegate/SKILL.md`
```markdown
---
name: delegate
description: Add task to TASKS.md
argument-hint: <department> <task>
allowed-tools: Read, Edit
user-invocable: true
disable-model-invocation: true
---

1. Read {{WORKSPACE}}/TASKS.md
2. Determine correct section (Today/Followups/Backlog based on urgency)
3. Append: - [ ] <task> @dept:<tag> @priority:medium @owner:<agent|user> @due:<YYYY-MM-DD>
4. Confirm and show the section where task was added
```

### /discuss — Decision Capture
`~/.claude/skills/discuss/SKILL.md`
```markdown
---
name: discuss
description: Capture decisions before planning — locks constraints for downstream agents
argument-hint: <topic>
allowed-tools: Read, Write, Edit
user-invocable: true
---

1. Read STATE.md
2. Identify 2-4 gray areas specific to the task type
3. Ask 1-2 focused questions per area with concrete options
4. Write decisions to CONTEXT.md:
   ## [Topic] — [DATE]
   - [Decision]: [Choice] (LOCKED)
5. Update STATE.md
```

### /verify-work — Verify Completed Work
`~/.claude/skills/verify-work/SKILL.md`
```markdown
---
name: verify-work
description: Verify completed work from user's perspective, auto-fix gaps
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
user-invocable: true
---

1. Read STATE.md for current position
2. Read recent deliverables (check git log, find new/modified files)
3. Extract testable behaviors from what was built
4. Present one test at a time. User responds in plain text.
5. On failure: spawn debug subagent, create fix plan, execute, re-verify
6. Persist results to VERIFICATION.md
7. Update STATE.md
```

### /quick — Fast Ad-Hoc Tasks
`~/.claude/skills/quick/SKILL.md`
```markdown
---
name: quick
description: Fast ad-hoc task — plan and execute without full ceremony
argument-hint: <description of fix or change>
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
user-invocable: true
---

1. Read STATE.md
2. Create plan with 1-3 task blocks (no research phase)
3. Execute tasks with atomic git commits per task
4. Update STATE.md
5. Report what was done and what was verified
```

### /ops-status — Task Dashboard
`~/.claude/skills/ops-status/SKILL.md`
```markdown
---
name: ops-status
description: Task dashboard grouped by department
allowed-tools: Read, Glob, Grep
user-invocable: true
disable-model-invocation: true
---

Read TASKS.md. Group tasks by @dept: tag.
Count active (non-blocked), completed, and blocked per department.
Output summary table. Flag departments with 0 active or >3 blocked.
```

## Step 6: Custom Agents (Multi-Agent Teams)

Create agents in `~/.claude/agents/`. Each agent has a specific role and model tier.

### Model Tiering Strategy
| Tier | Model | Use For |
|------|-------|---------|
| Lead | Opus | Planning, architecture, complex reasoning, orchestration |
| Worker | Sonnet | Code generation, execution, standard tasks |
| Bulk | Haiku | Documentation, simple lookups, bulk content |

### Agent Template
`~/.claude/agents/{{name}}.md`
```markdown
---
name: {{agent-name}}
description: {{one-line description}}
tools: {{comma-separated tool list}}
model: {{opus|sonnet|haiku}}
---

{{Role description}}.

## Context (read first)
- {{path to relevant CLAUDE.md or context files}}
- {{path to TASKS.md}} (filter by @dept:{{tag}})

## Workflow
1. Read TASKS.md, pick highest priority unclaimed task
2. Mark task as started
3. Execute within scope
4. Mark task complete with (claude, DATE)
5. Report what was built and verified

## Constraints
- Stay in {{department}} scope
- Escalate cross-department needs to lead agent
```

### Rules File
Create `~/.claude/rules/agent-policy.md`:
```markdown
# Agent & Team Policy

## Subagents (default)
For investigation, audits, research, large output. Fast, single-session.

## Agent Teams (escalation only)
Only when workers need to communicate across layers.
NOT for: same-file edits, sequential work, tightly coupled refactors.
```

## Step 7: Commands (Git Workflows)

### /commit
`~/.claude/commands/commit.md`
```markdown
---
allowed-tools: Bash, Read, Grep
---
Analyze staged changes and generate a conventional commit message.
Types: feat, fix, refactor, docs, test, chore, perf, style.
Format: type(scope): description
```

### /pr
`~/.claude/commands/pr.md`
```markdown
---
allowed-tools: Bash, Read, Glob, Grep
---
Generate PR title and description from branch commits.
Include: summary, changes list, testing instructions.
```

### /catchup
`~/.claude/commands/catchup.md`
```markdown
---
allowed-tools: Bash, Read, Glob, Grep
---
Read all changed files in current git branch and summarize the work state.
Compare to base branch (main/master). List changed files with descriptions.
```

## Step 8: Status Line (Windows PowerShell)

`~/.claude/statusline.ps1` — Shows model, directory, context usage, tokens, and cost in the CLI.

```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = [Console]::In.ReadToEnd()
$data = $raw -replace '\\', '\\\\' | ConvertFrom-Json

$model = if ($data.model.display_name) { $data.model.display_name } else { '?' }
$dir = Split-Path -Leaf $data.workspace.current_dir
$pct = if ($data.context_window.used_percentage) {
    [math]::Round([double]$data.context_window.used_percentage)
} else { 0 }
$cost = if ($data.cost.total_cost_usd) {
    '$' + '{0:N2}' -f [double]$data.cost.total_cost_usd
} else { '$0.00' }

$totalTokens = 0
if ($data.context_window.total_input_tokens) { $totalTokens += [double]$data.context_window.total_input_tokens }
if ($data.context_window.total_output_tokens) { $totalTokens += [double]$data.context_window.total_output_tokens }
if ($totalTokens -ge 1000000) {
    $tokenStr = '{0:N1}M' -f ($totalTokens / 1000000)
} elseif ($totalTokens -ge 1000) {
    $tokenStr = '{0:N1}k' -f ($totalTokens / 1000)
} else {
    $tokenStr = [string]$totalTokens
}

$branch = ''
try {
    Push-Location $data.workspace.current_dir
    $b = git branch --show-current 2>$null
    if ($b) { $branch = "($b)" }
    Pop-Location
} catch {}

$esc = [char]27
$reset = "${esc}[0m"
$dim = "${esc}[2m"
if ($pct -ge 90) { $ctxColor = "${esc}[91m" }
elseif ($pct -ge 70) { $ctxColor = "${esc}[93m" }
else { $ctxColor = "${esc}[92m" }

Write-Output "${dim}[$model]${reset} $dir${dim}${branch}${reset} ${ctxColor}${pct}%${reset} ${dim}|${reset} $tokenStr ${dim}|${reset} $cost"
```

## Step 9: Workspace Structure

Set up your working directory with department folders:

```
~/Desktop/{{Company}}/
├── TASKS.md              <- Single source of truth (all tasks, tagged by @dept:)
├── STATE.md              <- Current position, recent decisions, blockers (<100 lines)
├── CONTEXT.md            <- Locked decisions from /discuss
├── LESSONS.md            <- Corrections and rules to prevent repeat mistakes
├── DECISIONS.md          <- Architecture/business decisions that outlive sessions
│
├── {{Dept1}}/
│   ├── CLAUDE.md         <- Department role definition
│   └── context/
│       ├── NOW.md        <- Current department state
│       └── TEAM.md       <- People + roles
│
├── {{Dept2}}/
│   ├── CLAUDE.md
│   └── context/
│
└── {{Dept3}}/
    ├── CLAUDE.md
    └── context/
```

### TASKS.md Schema
```markdown
# Tasks
<!-- Schema: - [ ] Task @dept:tag @priority:high|medium|low @owner:name @due:YYYY-MM-DD @blocked-by:"reason" @started:YYYY-MM-DD -->

## Today
- [ ] Task description @dept:ops @priority:high @owner:claude

## Followups
- [ ] Follow up on X @dept:sales @priority:medium @due:2026-04-15

## Backlog
- [ ] Future task @dept:dev @priority:low

## Completed
- [x] Done task (claude, 2026-04-08) @dept:ops
```

### STATE.md Template
```markdown
# State

## Current Position
- Active project: [name]
- Phase: [explore/discuss/plan/execute/verify]
- Last session: [YYYY-MM-DD, what happened]

## Recent Decisions (last 5)
- [date]: [decision] — [why]

## Blockers
- [blocker] — [who owns it]
```

## Step 10: MCP Servers (Connect External Tools)

MCP (Model Context Protocol) servers let Claude interact with external services directly.

### Essential for Business
```bash
# Gmail — read/draft emails
claude mcp add gmail -- npx -y @anthropic-ai/claude-gmail-mcp

# Google Calendar — schedule management
claude mcp add google-calendar -- npx -y @anthropic-ai/claude-google-calendar-mcp

# Chrome browser automation — research, web tasks
claude mcp add claude-in-chrome  # Follow extension setup guide
```

### For Development
```bash
# Context7 — current library docs (replaces outdated training data)
# Installed via plugin: context7@claude-plugins-official

# Supabase — database management
claude mcp add supabase -- npx -y @anthropic-ai/claude-supabase-mcp

# GitHub — PR reviews, issue management
# Installed via plugin: github@claude-plugins-official
```

### For Investment/Finance
```bash
# Zerodha Kite MCP — portfolio, holdings, P&L, orders (FREE)
npm install @zerodha/kite-mcp
# Configure in settings.json MCP section
```

### For Marketing
```bash
# Canva — design generation
claude mcp add canva -- npx -y @anthropic-ai/claude-canva-mcp

# n8n — workflow automation
claude mcp add n8n -- npx -y @anthropic-ai/claude-n8n-mcp
```

**Warning**: Each MCP server adds ~5-15K tokens of context. With 10+ servers, you'll see ~80K tokens of MCP context. Monitor with the status line. Opus 4.6's 1M context handles this fine, but be aware.

## Step 11: New Features (April 2026)

### Auto Mode
Replaces the old `--dangerously-skip-permissions`. Safe actions run automatically; risky ones get blocked.
```bash
claude --auto  # or set defaultMode: "auto" in settings.json
```

### Scheduled Remote Tasks
Run agents on Anthropic's cloud even when your laptop is off:
```
/schedule "daily standup" --cron "0 7 * * *" --prompt "/standup"
/schedule "evening log" --cron "0 18 * * *" --prompt "/log"
```

### Loop (Recurring Monitoring)
```
/loop 5m "check deployment status"  # Runs every 5 minutes
```

### /powerup (Interactive Tutorials)
```
/powerup  # Learn features with animated in-terminal demos
```

### Computer Use on Windows
Claude can control your desktop — open files, click, navigate. Available on Pro/Max plans.

## Step 12: Project-Level Overrides

For specific projects, create `.claude/settings.local.json` in the project directory:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo [AUTO-START] {{YOUR_STARTUP_MESSAGE}}",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

This lets each project have its own personality, permissions, and startup behavior.

## Verification Checklist

After setup, test each component:

- [ ] `claude` launches and shows your status line (model, context %, cost)
- [ ] `claude "read my CLAUDE.md and tell me my role"` — confirms it reads your instructions
- [ ] Try `git add .` inside Claude — should be **blocked** by hook
- [ ] Try `git push --force main` — should be **blocked** by hook
- [ ] Make a commit — should auto-push to remote
- [ ] `/standup` — shows task briefing
- [ ] `/delegate ops "test task"` — adds task to TASKS.md
- [ ] `/ops-status` — shows task dashboard
- [ ] `/quick "fix typo in README"` — plans + executes + commits
- [ ] `/verify-work` — presents test cases for recent work
- [ ] Test an MCP server: "check my calendar for tomorrow" (if Google Calendar connected)

## Warnings (From Experience)

1. **Don't install the full GSD plugin** — absorb the good parts (Discuss → Plan → Execute → Verify) natively. The full plugin adds too much ceremony.
2. **Don't use giant router workflows** — split into reusable sub-workflows with configuration.
3. **Don't embed prompts in automation nodes** — keep prompts in Git for version control.
4. **Monitor MCP context bloat** — 10+ servers = ~80K tokens. You have 1M, but it adds up.
5. **3 attempts max** — if Claude fails 3 times, stop and rethink the approach. Don't let it loop.
6. **Always verify before claiming success** — the /verify-work skill exists for a reason.

---

*Built by NexAI Labs. This is how we run our company.*
*Contact: Rahul | nexailabs.com*
