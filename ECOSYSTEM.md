# Claude Code Ecosystem

> A curated directory of tools, CLIs, plugins, frameworks, and resources that make Claude Code more powerful. Verified and tested by NexAI Labs.

---

## Table of Contents

- [CLI Tools](#cli-tools)
- [Claude Code Plugins](#claude-code-plugins)
- [MCP Servers](#mcp-servers)
- [Agent Orchestration](#agent-orchestration)
- [Frameworks & Repos](#frameworks--repos)
- [Awesome Lists](#awesome-lists)
- [Browser Tools](#browser-tools)
- [Prompt Engineering](#prompt-engineering)
- [Multi-CLI Setups](#multi-cli-setups)
- [Web Platforms](#web-platforms)
- [Community Resources](#community-resources)

---

## CLI Tools

Install globally and use alongside Claude Code via the Bash tool.

| Tool | Install | Stars | What It Does |
|------|---------|-------|-------------|
| **[CLI-Anything](https://github.com/HKUDS/CLI-Anything)** | `pip install cli-anything` | ~21K | Wraps any software (GIMP, Blender, OBS, Audacity) into a structured CLI that agents can call. Also available as CC plugin. |
| **[Playwright CLI](https://github.com/microsoft/playwright-cli)** | `npm install -g @playwright/cli@latest` | - | Token-efficient browser automation. ~4.6x fewer tokens than Playwright MCP. Use `playwright-cli snapshot`, `click`, `screenshot`. |
| **[Google Workspace CLI (gws)](https://github.com/googleworkspace/cli)** | `npm install -g @googleworkspace/cli` | ~22K | One CLI for Drive, Gmail, Calendar, Sheets, Docs, Chat, Admin. Ships 100+ agent skills. Also has MCP mode via `gws mcp`. |
| **[GitHub CLI (gh)](https://github.com/cli/cli)** | [cli.github.com](https://cli.github.com) | 38K+ | PRs, issues, repos, actions from terminal. Claude Code uses this natively. |
| **[Codex CLI](https://github.com/openai/codex)** | `npm install -g @openai/codex` | - | OpenAI's coding CLI. Run alongside Claude Code for second opinions and adversarial code review. |
| **[Gemini CLI](https://github.com/google/gemini-cli)** | `npm install -g @google/gemini-cli` | - | Google's coding CLI. 1M token context, free tier (60rpm). Great for research tasks. |
| **[Cortex Linux](https://github.com/cortexlinux/cortex)** | `pip install -e .` (from repo) | - | AI-native OS layer for Debian/Ubuntu. Natural language system commands, hardware-aware optimization, self-healing config. |
| **jq** | `apt install jq` / `brew install jq` | - | JSON processor. Essential for parsing API responses. |
| **ripgrep (rg)** | `apt install ripgrep` / `brew install ripgrep` | - | Fast code search. Claude Code uses Grep internally, but rg is useful for manual searches. |
| **lazygit** | `brew install lazygit` | - | Terminal UI for git. Visual branch management alongside Claude Code's git operations. |

---

## Claude Code Plugins

Install via `/plugin marketplace add <org>/<repo>` then `/plugin install <name>@<marketplace>`.

### Official Plugins (Recommended)

| Plugin | Install | What It Does |
|--------|---------|-------------|
| **superpowers** | `superpowers@claude-plugins-official` | Planning, code review, brainstorming, systematic debugging, verification. The meta-plugin. |
| **context7** | `context7@claude-plugins-official` | Current library docs. Replaces outdated training data for React, Next.js, FastAPI, etc. |
| **security-guidance** | `security-guidance@claude-plugins-official` | OWASP vulnerability scanning on every edit. |
| **code-review** | `code-review@claude-plugins-official` | PR review and code quality checks. |
| **code-simplifier** | `code-simplifier@claude-plugins-official` | Refactor for clarity and maintainability. |
| **frontend-design** | `frontend-design@claude-plugins-official` | Production-grade UI generation with high design quality. |
| **github** | `github@claude-plugins-official` | GitHub integration. Needs GITHUB_PERSONAL_ACCESS_TOKEN. |
| **playwright** | `playwright@claude-plugins-official` | Browser automation via Playwright protocol. |
| **skill-creator** | `skill-creator@claude-plugins-official` | Build, evaluate, and improve custom skills faster. |
| **hookify** | `hookify@claude-plugins-official` | Create hooks interactively (no manual JSON editing). |
| **feature-dev** | `feature-dev@claude-plugins-official` | Guided feature development workflow. |
| **commit-commands** | `commit-commands@claude-plugins-official` | Enhanced git commit workflow. |
| **pr-review-toolkit** | `pr-review-toolkit@claude-plugins-official` | Comprehensive PR review with checklist. |
| **telegram** | `telegram@claude-plugins-official` | Control Claude Code from Telegram on your phone. |
| **pyright-lsp** | `pyright-lsp@claude-plugins-official` | Python type checking on every edit. Requires `pip install pyright`. |
| **typescript-lsp** | `typescript-lsp@claude-plugins-official` | TypeScript type checking. |

### Third-Party Plugins

| Plugin | Source | What It Does |
|--------|--------|-------------|
| **[codex-plugin-cc](https://github.com/openai/codex-plugin-cc)** | `/plugin marketplace add openai/codex-plugin-cc` | Run Codex code reviews from inside Claude Code. Commands: `/codex:review`, `/codex:adversarial-review`, `/codex:rescue`. Apache 2.0. |
| **[claude-mem](https://github.com/thedotmack/claude-mem)** | `npx claude-mem install` | ~46K stars. Persistent memory — auto-captures everything Claude does, compresses with AI, injects relevant context into future sessions. SQLite + Chroma vector search. |
| **[oh-my-claudecode](https://github.com/yeachan-heo/oh-my-claudecode)** | Plugin marketplace | 32 specialized agents, 3-5x speedup, 30-50% token savings. Hit #1 trending on GitHub. |
| **[CLI-Anything](https://github.com/HKUDS/CLI-Anything)** | `/plugin marketplace add HKUDS/CLI-Anything` | Also works as a plugin — wraps any software into agent-callable CLI. |

---

## MCP Servers

Connect external services via Model Context Protocol.

### Business & Productivity

| Server | Install | What It Does |
|--------|---------|-------------|
| **Gmail** | `claude mcp add gmail` | Read, draft, search emails. |
| **Google Calendar** | `claude mcp add google-calendar` | Schedule management, find free time. |
| **Notion** | `claude mcp add notion` | Read/write Notion pages and databases. |
| **Canva** | `claude mcp add canva` | Generate and edit designs. |
| **Attio** | `claude mcp add attio --transport sse https://mcp.attio.com/v1/sse` | Modern CRM with AI-native features. |
| **HubSpot MCP** | Community | CRM data — contacts, companies, deals via natural language. |
| **Salesforce MCP** | Community | 60+ tools for CRM records, reports, deployments. |
| **Apollo MCP** | Community | 34+ tools for people search, contact enrichment, email sequences. |
| **Zapier MCP** | Community | Universal workflow dispatcher. Bridges entire business app ecosystem. |

### Development

| Server | Install | What It Does |
|--------|---------|-------------|
| **Supabase** | `claude mcp add supabase` | Database management, migrations, edge functions. |
| **Vercel** | `claude mcp add vercel` | Deploy, monitor, manage projects. |
| **Cloudflare** | `claude mcp add cloudflare` | Workers, D1, R2, KV management. |
| **n8n** | `claude mcp add n8n` | Workflow automation. |
| **[GitHub MCP](https://github.com/github/github-mcp-server)** | `claude mcp add github -- npx -y @github/mcp-server` | Official GitHub API integration as structured MCP tools. |
| **Google Workspace** | `gws mcp` (from gws CLI) | Gmail, Drive, Docs, Calendar, Sheets as MCP tools. |

### Finance

| Server | Install | What It Does |
|--------|---------|-------------|
| **[Zerodha Kite MCP](https://github.com/zerodha/kite-mcp-server)** | `npm install @zerodha/kite-mcp` | Portfolio, holdings, P&L, order history. FREE. Indian markets. |

### AI & Memory

| Server | Install | What It Does |
|--------|---------|-------------|
| **[claude-peers-mcp](https://github.com/louislva/claude-peers-mcp)** | `claude mcp add claude-peers -- bun ~/claude-peers-mcp/server.ts` | ~1.7K stars. Peer discovery and messaging between Claude Code instances. Broker daemon + SQLite. |
| **[OpenSpace](https://github.com/HKUDS/OpenSpace)** | `pip install -e .` + MCP config | ~4.1K stars. Self-evolving skills — AUTO-FIX, AUTO-IMPROVE, AUTO-LEARN. 46% fewer tokens. Quality jumped from 40.8% to 70.8%. |
| **[claude_memory](https://github.com/codenamev/claude_memory)** | MCP + hooks | Long-term self-managed memory. Zero-config, auto-extracts durable facts. |

---

## Agent Orchestration

Frameworks for running multiple Claude Code agents with coordination.

| Tool | Install | Stars | What It Does |
|------|---------|-------|-------------|
| **[Paperclip](https://github.com/paperclipai/paperclip)** | `npm i paperclipai` | ~36K | Open-source orchestration for zero-human companies. Org charts, budgets, goals, governance between AI agents. Built specifically for Claude Code. [paperclip.ing](https://paperclip.ing) |
| **[Ruflo](https://github.com/ruvnet/ruflo)** | `npm install -g ruflo@latest` | ~27K | Leading agent orchestration platform. ~100 specialized agents in parallel, RAG integration, distributed swarm intelligence. MCP: `claude mcp add ruflo -- npx -y ruflo@latest mcp start` |
| **[oh-my-claudecode](https://github.com/yeachan-heo/oh-my-claudecode)** | Plugin | 858+ | Teams-first multi-agent orchestration. 32 specialized agents, 3-5x speedup. |
| **[claude-peers-mcp](https://github.com/louislva/claude-peers-mcp)** | MCP server | ~1.7K | Peer discovery and messaging. Multiple CC instances communicate and share context. |
| **[claude-code-workflow-orchestration](https://github.com/barkain/claude-code-workflow-orchestration)** | GitHub | - | Auto task decomposition, parallel agent execution, plan mode integration. |

---

## Frameworks & Repos

### Autonomous Research

| Repo | Stars | What It Does |
|------|-------|-------------|
| **[autoresearch (Karpathy)](https://github.com/karpathy/autoresearch)** | ~53.5K | Andrej Karpathy's autonomous research agent. AI modifies code, trains, evaluates, keeps or discards. ~12 experiments/hour. Programs via `program.md` markdown files. |
| **[OpenSpace](https://github.com/HKUDS/OpenSpace)** | ~4.1K | Self-improving skills for AI agents. Skills that learn from usage and automatically optimize. |

### Enhancement Repos

| Repo | What It Does |
|------|-------------|
| **[awesome-claude-code-toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit)** | Most comprehensive CC toolkit: 135 agents, 35 skills, 42 commands, 150+ plugins, 19 hooks. Hit #1 trending on GitHub. |
| **[claude-code-plugins-plus-skills](https://github.com/jeremylongshore/claude-code-plugins-plus-skills)** | 340+ plugins, 1,367 skills. CCPI package manager. |
| **[claude-skills](https://github.com/alirezarezvani/claude-skills)** | 220+ skills for engineering, marketing, product, compliance, C-level. |
| **[claude-code-skills](https://github.com/levnikolaevich/claude-code-skills)** | Full delivery lifecycle: agile pipeline, multi-model review, codebase audits. Custom MCP servers: hex-line, hex-graph, hex-ssh. |
| **[everything-claude-code](https://github.com/affaan-m/everything-claude-code)** | Agent harness performance optimization: skills, instincts, memory, security. |
| **[claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide)** | Community guide with advanced patterns and configurations. |

### Skill Collections

| Repo | Focus |
|------|-------|
| **[claude-ads](https://github.com/AgriciDaniel/claude-ads)** | Ad audit/optimization, 190+ checks. Google + Meta + LinkedIn ads. |
| **[marketingskills](https://github.com/coreyhaines31/marketingskills)** | Paid ads, ad creative, analytics skills. |
| **[n8n-skills](https://github.com/czlonkowski/n8n-skills)** | Build n8n workflows from Claude Code. |

### Hooks Collections

| Repo | What It Offers |
|------|---------------|
| **[karanb192/claude-code-hooks](https://github.com/karanb192/claude-code-hooks)** | Ready-to-use hooks for safety, automation, notifications. |
| **[disler/claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery)** | UV single-file Python scripts, cleanly separated hook logic. |
| **[johnlindquist/claude-hooks](https://github.com/johnlindquist/claude-hooks)** | TypeScript-powered with full type safety and auto-completion. |
| **[shanraisshan/claude-code-hooks](https://github.com/shanraisshan/claude-code-hooks)** | Voice/sound hooks (session start, tool use, agent response). |

---

## Awesome Lists

| List | Stars | Focus |
|------|-------|-------|
| **[awesome-claude-code-toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit)** | Trending | 135 agents, 35 skills, 150+ plugins, 19 hooks, 7 templates |
| **[awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)** | - | Curated skills, hooks, commands, orchestrators, system prompt docs |
| **[awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills)** | - | Skills, resources, and tools for customizing Claude workflows |
| **[awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills)** | ~22K | 1,234+ skills compatible with Claude Code, Codex, Gemini CLI, Cursor, and 7+ tools |
| **[awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers)** | - | Model Context Protocol servers directory |

---

## Browser Tools

| Tool | Type | What It Does |
|------|------|-------------|
| **[Claude in Chrome](https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn)** | Chrome Extension | Official Anthropic extension. Browser automation, page reading, form filling, GIF recording. Shares your login state. Beta. Chrome/Edge only. |
| **[Playwright CLI](https://github.com/microsoft/playwright-cli)** | CLI Tool | `npm install -g @playwright/cli@latest`. ~4.6x fewer tokens than MCP. Saves snapshots to disk. Use for complex scraping/testing. |

---

## Prompt Engineering

See the [prompts/](prompts/) directory:

| File | What It Is |
|------|-----------|
| **[Prompt Enhancer v1](prompts/prompt-enhancer-v1.md)** | Prompt optimization framework. ATOMIC framework (Agent, Task, Output, Method, Input, Check). CoT, CoVe, meta-prompting. |
| **[Prompt Enhancer v2](prompts/prompt-enhancer-v2.md)** | 22KB advanced context engineering system. 18-step optimization protocol, model-specific optimizers (GPT-4o, Claude, Gemini), self-consistency validation, security defense matrix, enterprise integration. |

---

## Multi-CLI Setups

Run Claude Code alongside other AI CLIs. See the [guides/](guides/) directory:

| Guide | What It Covers |
|-------|---------------|
| **[Multi-CLI Setup](guides/multi-cli-setup.md)** | Architecture for Claude Code (Windows) + Codex (WSL) + Gemini (WSL). Shared filesystem, task queue, troubleshooting. |
| **[WSL/Windows Tips](guides/wsl-windows-tips.md)** | Path handling gotchas, cross-environment commands, the things nobody warns you about. |
| **[CLI Tools Reference](guides/cli-tools-reference.md)** | Install commands, compatibility matrix, auth methods, performance rankings, known issues. |

---

## Web Platforms

AI platforms in the "run your business with agents" space.

| Platform | What It Does | Pricing |
|----------|-------------|---------|
| **[Polsia](https://polsia.com)** | Autonomous AI company builder. CEO, Engineering, Marketing, Support agents. Solo founder hit $2M ARR in 2 weeks. | $49/mo + 20% of revenue |
| **[Accio Work (Alibaba)](https://accio.works)** | Enterprise AI agent platform for procurement, compliance, marketing, cross-border logistics. VAT filings across 100+ markets. | Enterprise pricing |
| **[Claude.ai/code](https://claude.ai/code)** | Web-based Claude Code. Run sessions from browser. | Included with subscription |

---

## Community Resources

| Resource | Link |
|----------|------|
| **Official Docs** | [code.claude.com/docs/en](https://code.claude.com/docs/en) |
| **GitHub Issues** | [anthropics/claude-code](https://github.com/anthropics/claude-code) |
| **Changelog** | [code.claude.com/docs/en/changelog](https://code.claude.com/docs/en/changelog) |
| **Reddit** | [r/ClaudeAI](https://reddit.com/r/ClaudeAI) |
| **Discord** | [discord.gg/anthropic](https://discord.gg/anthropic) |

---

*Curated by [NexAI Labs](https://nexailabs.com). PRs welcome — if you know a tool that should be here, open an issue.*
