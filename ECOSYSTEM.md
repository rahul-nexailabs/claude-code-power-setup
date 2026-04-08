# Claude Code Ecosystem
### Tools, CLIs, Plugins, Frameworks, and Resources

> A curated list of everything that makes Claude Code more powerful. Tested and compiled by NexAI Labs.

---

## Table of Contents

- [CLI Tools](#cli-tools)
- [Claude Code Plugins](#claude-code-plugins)
- [MCP Servers](#mcp-servers)
- [Frameworks & Repos](#frameworks--repos)
- [Awesome Lists](#awesome-lists)
- [Chrome & Browser Tools](#chrome--browser-tools)
- [Prompt Engineering](#prompt-engineering)
- [Multi-CLI Setups](#multi-cli-setups)
- [Community Resources](#community-resources)

---

## CLI Tools

Tools you install globally and use alongside Claude Code.

| Tool | Install | What It Does |
|------|---------|-------------|
| **GitHub CLI (gh)** | `npm install -g gh` or [cli.github.com](https://cli.github.com) | PRs, issues, repos, actions from terminal. Claude Code uses this natively for GitHub operations. |
| **Playwright CLI** | `npx playwright install` | Browser automation from terminal. Often better than Playwright MCP for complex scenarios — direct control, no protocol overhead. |
| **Google Workspace CLI (gcloud)** | [cloud.google.com/sdk](https://cloud.google.com/sdk/docs/install) | Gmail, Calendar, Drive from terminal. Complements Gmail/Calendar MCP servers. |
| **Codex CLI** | `npm install -g @openai/codex` | OpenAI's coding CLI. Run alongside Claude Code for second opinions. |
| **Gemini CLI** | `npm install -g @google/gemini-cli` | Google's coding CLI. 1M token context, free tier (60rpm). Great for research tasks. |
| **jq** | `apt install jq` / `brew install jq` | JSON processor. Essential for parsing API responses and MCP outputs. |
| **fzf** | `apt install fzf` / `brew install fzf` | Fuzzy finder. Speeds up file navigation in terminal. |
| **ripgrep (rg)** | `apt install ripgrep` / `brew install ripgrep` | Fast code search. Claude Code uses Grep internally, but rg is useful for manual searches. |
| **lazygit** | `brew install lazygit` | Terminal UI for git. Visual branch management alongside Claude Code's git operations. |

---

## Claude Code Plugins

Install via `/plugin install name@marketplace`.

### Official Plugins (Recommended)

| Plugin | Install | What It Does |
|--------|---------|-------------|
| **superpowers** | `superpowers@claude-plugins-official` | Planning, code review, brainstorming, systematic debugging, verification. The meta-plugin. |
| **context7** | `context7@claude-plugins-official` | Current library docs. Replaces outdated training data for React, Next.js, FastAPI, etc. |
| **security-guidance** | `security-guidance@claude-plugins-official` | OWASP vulnerability scanning on every edit. |
| **code-review** | `code-review@claude-plugins-official` | PR review and code quality checks. |
| **code-simplifier** | `code-simplifier@claude-plugins-official` | Refactor for clarity and maintainability. |
| **frontend-design** | `frontend-design@claude-plugins-official` | Production-grade UI generation with high design quality. |
| **github** | `github@claude-plugins-official` | GitHub integration (PRs, issues, checks). Needs GITHUB_PERSONAL_ACCESS_TOKEN. |
| **playwright** | `playwright@claude-plugins-official` | Browser automation via Playwright protocol. |

### Additional Plugins Worth Adding

| Plugin | Install | What It Does |
|--------|---------|-------------|
| **skill-creator** | `skill-creator@claude-plugins-official` | Build, evaluate, and improve custom skills faster. |
| **hookify** | `hookify@claude-plugins-official` | Create hooks interactively (no manual JSON editing). |
| **feature-dev** | `feature-dev@claude-plugins-official` | Guided feature development workflow. |
| **commit-commands** | `commit-commands@claude-plugins-official` | Enhanced git commit workflow. |
| **pr-review-toolkit** | `pr-review-toolkit@claude-plugins-official` | Comprehensive PR review with checklist. |
| **telegram** | `telegram@claude-plugins-official` | Control Claude Code from Telegram on your phone. |
| **pyright-lsp** | `pyright-lsp@claude-plugins-official` | Python type checking on every edit. Requires `pip install pyright`. |
| **typescript-lsp** | `typescript-lsp@claude-plugins-official` | TypeScript type checking. |

---

## MCP Servers

Connect external services to Claude Code via Model Context Protocol.

### Business & Productivity

| Server | Install | What It Does |
|--------|---------|-------------|
| **Gmail** | `claude mcp add gmail` | Read, draft, search emails. Summarize inbox. |
| **Google Calendar** | `claude mcp add google-calendar` | Schedule management, find free time, create events. |
| **Notion** | `claude mcp add notion` | Read/write Notion pages and databases. |
| **Canva** | `claude mcp add canva` | Generate and edit designs programmatically. |
| **Clay** | Via Claude.ai MCP | Lead enrichment and CRM data. |
| **Attio** | `claude mcp add attio --transport sse https://mcp.attio.com/v1/sse` | Modern CRM with AI-native features. |

### Development

| Server | Install | What It Does |
|--------|---------|-------------|
| **Supabase** | `claude mcp add supabase` | Database management, migrations, edge functions. |
| **Vercel** | `claude mcp add vercel` | Deploy, monitor, manage Vercel projects. |
| **Cloudflare** | `claude mcp add cloudflare` | Workers, D1, R2, KV management. |
| **n8n** | `claude mcp add n8n` | Workflow automation (search, execute, manage workflows). |
| **Hugging Face** | `claude mcp add hugging-face` | Model search, paper search, Hub queries. |

### Finance & Investing

| Server | Install | What It Does |
|--------|---------|-------------|
| **Zerodha Kite MCP** | `npm install @zerodha/kite-mcp` | Portfolio, holdings, P&L, order history. FREE. Indian markets. |

### Browser Automation

| Server | Install | What It Does |
|--------|---------|-------------|
| **Claude-in-Chrome** | Chrome extension + `claude mcp add claude-in-chrome` | Full browser control, screenshots, form filling, GIF recording. |
| **Playwright MCP** | Via `playwright@claude-plugins-official` | Headless browser automation. |

---

## Frameworks & Repos

Open-source projects that extend or complement Claude Code.

### Agent Frameworks

| Repo | Stars | What It Does |
|------|-------|-------------|
| **[Accio Work (Alibaba)](https://github.com/anthropics/claude-code)** | - | AI agent framework from Alibaba for automated work execution. Task decomposition, multi-step execution. |
| **[Paperclip](https://paperclip.ing)** | - | Multi-agent orchestration tool. Run 3+ autonomous Claude Code agents simultaneously with coordination. Prevents conflicts. |
| **[Cortex OS](https://github.com/cortexos)** | - | AI operating system layer. Provides persistent state, memory, and scheduling for AI agents. |
| **[OpenScape](https://github.com/openscape-ai/openscape)** | - | Self-improving skills for Claude Code. Skills that learn from usage and automatically optimize themselves. |
| **[claude-peers](https://github.com/anthropics/claude-peers)** | - | Multi-Claude coordination. Run multiple Claude Code instances that communicate and share context. |
| **[autoresearch (Karpathy)](https://github.com/karpathy/autoresearch)** | - | Andrej Karpathy's automated research agent. Autonomously searches, reads papers, synthesizes findings. |

### Claude Code Enhancement Repos

| Repo | What It Does |
|------|-------------|
| **[claude-code-power-setup](https://github.com/rahul-nexailabs/claude-code-power-setup)** | This repo. Production-grade Claude Code setup. |
| **[awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)** | Curated list of skills, hooks, commands, agents for Claude Code. |
| **[claude-code-plugins-plus-skills](https://github.com/jeremylongshore/claude-code-plugins-plus-skills)** | 340+ plugins, 1,367 skills. CCPI package manager. |
| **[claude-skills](https://github.com/alirezarezvani/claude-skills)** | 220+ skills for engineering, marketing, product, compliance, C-level. |
| **[claude-code-skills](https://github.com/levnikolaevich/claude-code-skills)** | Full delivery lifecycle: agile pipeline, multi-model review, codebase audits. |
| **[claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide)** | Community guide with advanced patterns and configurations. |

### Skill Collections

| Repo | Focus |
|------|-------|
| **[claude-ads](https://github.com/AgriciDaniel/claude-ads)** | Ad audit/optimization, 190+ checks. Google + Meta + LinkedIn ads. |
| **[marketingskills](https://github.com/coreyhaines31/marketingskills)** | Paid ads, ad creative, analytics skills. |
| **[n8n-skills](https://github.com/czlonkowski/n8n-skills)** | Build n8n workflows from Claude Code. |

---

## Awesome Lists

Curated collections of AI tools and resources.

| List | Focus |
|------|-------|
| **[awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)** | Claude Code specific — skills, hooks, agents, MCP servers |
| **[awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers)** | Model Context Protocol servers directory |
| **[awesome-ai-agents](https://github.com/e2b-dev/awesome-ai-agents)** | AI agent frameworks and tools |
| **[awesome-llm-apps](https://github.com/Shubhamsaboo/awesome-llm-apps)** | LLM application examples and patterns |

---

## Chrome & Browser Tools

| Tool | What It Does |
|------|-------------|
| **[Claude-in-Chrome Extension](https://chromewebstore.google.com)** | Official Chrome extension for Claude Code. Browser automation, page reading, form filling, GIF recording. Requires Windows for native messaging. |
| **Playwright CLI** (`npx playwright`) | Direct browser automation. For complex scraping/testing, often more reliable than MCP. Supports headed/headless, multiple browsers. |

---

## Prompt Engineering

See the [prompts/](prompts/) directory for copy-paste ready frameworks:

| File | What It Is |
|------|-----------|
| **[Prompt Enhancer v1](prompts/prompt-enhancer-v1.md)** | Prompt optimization framework. Zero-shot, few-shot, CoT, CoVe, meta-prompting. ATOMIC framework (Agent, Task, Output, Method, Input, Check). |
| **[Prompt Enhancer v2](prompts/prompt-enhancer-v2.md)** | Advanced context engineering system. 18-step optimization protocol, model-specific optimizers (GPT-4o, Claude, Gemini), self-consistency validation, security defense matrix, enterprise integration. 22KB of battle-tested prompt architecture. |

---

## Multi-CLI Setups

Run Claude Code alongside other AI CLIs for maximum coverage.

See the [guides/](guides/) directory:

| Guide | What It Covers |
|-------|---------------|
| **[Multi-CLI Setup](guides/multi-cli-setup.md)** | Architecture for Claude Code (Windows) + Codex (WSL) + Gemini (WSL). Shared filesystem, task queue flow, troubleshooting. |
| **[WSL/Windows Tips](guides/wsl-windows-tips.md)** | Path handling, environment differences, cross-environment commands. The gotchas nobody warns you about. |
| **[CLI Tools Reference](guides/cli-tools-reference.md)** | Install commands, compatibility matrix, auth methods, performance rankings, known issues for Claude/Codex/Gemini. |

---

## Web Tools & Platforms

| Platform | What It Does |
|----------|-------------|
| **[Polsia](https://polsia.com)** | AI agent platform for autonomous business operations. Connects to multiple AI providers. |
| **[Claude.ai/code](https://claude.ai/code)** | Web-based Claude Code. Run sessions from browser without local CLI. |
| **[Anthropic Console](https://console.anthropic.com)** | API key management, usage monitoring, billing. |

---

## Community Resources

| Resource | What It Is |
|----------|-----------|
| **[Claude Code Docs](https://code.claude.com/docs/en)** | Official documentation |
| **[Claude Code GitHub](https://github.com/anthropics/claude-code)** | Issue tracker, release notes |
| **[Claude Code Changelog](https://code.claude.com/docs/en/changelog)** | What's new in each release |
| **[r/ClaudeAI](https://reddit.com/r/ClaudeAI)** | Reddit community |
| **[Claude Code Discord](https://discord.gg/anthropic)** | Official Discord |

---

*Curated by [NexAI Labs](https://nexailabs.com). PRs welcome.*
