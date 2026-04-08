# Claude Code Power Setup

**Turn Claude Code from a chatbot into an AI operating system for your business.**

This is the exact setup that runs [NexAI Labs](https://nexailabs.com) — hooks, skills, agents, safety rails, and automation. Battle-tested in production since January 2026.

---

## What's Inside

### Core Setup
| File | What It Is |
|------|-----------|
| [SETUP.md](SETUP.md) | Step-by-step setup guide (hooks, skills, agents, MCP, workspace) |
| [FEATURES.md](FEATURES.md) | Complete feature reference (60+ settings, 166+ env vars, 26 hooks, 49 plugins) |
| [ECOSYSTEM.md](ECOSYSTEM.md) | Curated tools, CLIs, plugins, frameworks, and resources |

### Ready-to-Use Components
| Directory | Contents |
|-----------|---------|
| [hooks/](hooks/) | 5 safety hook scripts (block force-push, block broad git add, auto-push, idle check, task verify) |
| [skills/](skills/) | 7 skill templates (/standup, /log, /delegate, /discuss, /verify-work, /quick, /ops-status) |
| [agents/](agents/) | 3 agent templates (lead, worker, researcher) with model tiering |
| [statusline.ps1](statusline.ps1) | Custom status line (model, context %, tokens, cost) |

### Guides & Prompts
| Directory | Contents |
|-----------|---------|
| [prompts/](prompts/) | Prompt engineering frameworks (v1 + v2 context engineering system) |
| [guides/](guides/) | Multi-CLI setup (Claude+Codex+Gemini), WSL/Windows tips, CLI compatibility reference |

---

## Quick Start

```bash
# 1. Clone
git clone https://github.com/rahul-nexailabs/claude-code-power-setup.git
cd claude-code-power-setup

# 2. Copy hooks
cp hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 3. Copy skills
cp -r skills/* ~/.claude/skills/

# 4. Copy agents
cp agents/*.md ~/.claude/agents/

# 5. Copy status line (Windows)
cp statusline.ps1 ~/.claude/

# 6. Follow SETUP.md for settings.json, CLAUDE.md, MCP servers, and workspace structure
```

---

## What You Get

- **Safety rails** — Hooks block force-push, broad git add, and .env staging. Teammates can't go idle.
- **Slash commands** — `/standup`, `/log`, `/delegate`, `/discuss`, `/verify-work`, `/quick`, `/ops-status`
- **Multi-agent teams** — Opus leads, Sonnet executes, Haiku handles bulk. Each agent has a specific domain.
- **GSD Hybrid workflow** — Discuss -> Plan -> Execute -> Verify. Lean markdown, no XML bloat.
- **Context protocol** — STATE.md (position), CONTEXT.md (locked decisions), LESSONS.md (self-improvement)
- **Auto-push** — Every commit auto-pushes to remote.
- **Ecosystem** — Curated CLI tools, plugins, MCP servers, frameworks. See [ECOSYSTEM.md](ECOSYSTEM.md).
- **Prompt engineering** — Battle-tested context engineering frameworks. See [prompts/](prompts/).

---

## Philosophy

This setup borrows from two frameworks:
- **GSD (Get Stuff Done)**: Discuss -> Plan -> Execute -> Verify cycle, locking decisions before building
- **Ralph Loop**: Atomic stories with boolean pass/fail, persistent memory

We rejected both as-is. GSD is overkill. Ralph is too permissive. The hybrid gives you spec-driven discipline with lean markdown execution.

> "No frameworks to install. No JSON schemas. No XML. Just markdown with phases and checkboxes that any CLI can execute."

---

## Requirements

- Claude Code CLI (`npm install -g @anthropic-ai/claude-code`)
- Node.js 18+
- Git + Git Bash (Windows) or bash (Mac/Linux)
- Python 3 (for hook scripts)
- Anthropic API key or Claude Max subscription

---

## Who This Is For

- **Founders** running their company through Claude Code
- **Developers** who want a production-grade setup
- **Teams** deploying Claude Code across an organization
- **Anyone** tired of the default Claude Code experience

---

## Built By

**[NexAI Labs](https://nexailabs.com)** — AI-powered operations for fashion, e-commerce, and business automation.

We build custom AI agent suites for businesses. If you want a setup like this tailored to your company, [reach out](mailto:rahul@nexailabs.com).

## License

MIT — use it, fork it, make it yours.
