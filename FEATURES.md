# Claude Code Complete Feature Reference (April 2026)

Compiled 2026-04-08. Based on official docs (code.claude.com), GitHub (anthropics/claude-code), and verified community sources.

---

## Table of Contents

1. [Settings (settings.json)](#1-settingsjson---all-keys)
2. [Environment Variables](#2-environment-variables)
3. [CLI Launch Flags](#3-cli-launch-flags)
4. [Permission Modes](#4-permission-modes)
5. [Hooks (All 26 Lifecycle Events)](#5-hooks---all-26-lifecycle-events)
6. [Built-in Slash Commands](#6-built-in-slash-commands)
7. [Bundled Skills](#7-bundled-skills)
8. [Official Plugins (All 49)](#8-official-plugins-marketplace)
9. [Custom Skills](#9-custom-skills)
10. [Custom Subagents](#10-custom-subagents)
11. [Agent Teams](#11-agent-teams)
12. [MCP Servers](#12-mcp-servers)
13. [Model Configuration](#13-model-configuration)
14. [Context Window Management](#14-context-window-management)
15. [Voice Dictation](#15-voice-dictation)
16. [AutoDream / Memory](#16-autodream--memory)
17. [Computer Use](#17-computer-use)
18. [Remote Control & Dispatch](#18-remote-control--dispatch)
19. [Scheduled Tasks / Loop](#19-scheduled-tasks--loop--cron)
20. [Ultraplan](#20-ultraplan)
21. [Fast Mode](#21-fast-mode)
22. [Channels (Telegram/Discord/iMessage)](#22-channels)
23. [Git Worktrees](#23-git-worktrees)
24. [Sandboxing](#24-sandboxing)
25. [Deep Links](#25-deep-links)
26. [Plugins System](#26-plugins-system)
27. [Output Styles & Themes](#27-output-styles--themes)
28. [Keybindings](#28-keybindings)
29. [Status Line](#29-status-line)
30. [IDE Integration](#30-ide-integration)
31. [What You're Missing](#31-gap-analysis---what-youre-missing)

---

## 1. settings.json - All Keys

**Location**: `~/.claude/settings.json` (user), `.claude/settings.json` (project), `.claude/settings.local.json` (local)

**Schema**: `"$schema": "https://json.schemastore.org/claude-code-settings.json"`

### Core Settings

| Key | Type | Description | Your Value |
|-----|------|-------------|------------|
| `agent` | string | Run main thread as a named subagent | -- |
| `alwaysThinkingEnabled` | bool | Extended thinking always on | -- |
| `apiKeyHelper` | string | Script to generate auth value | -- |
| `attribution` | object | Customize git commit/PR attribution (`{commit, pr}`) | -- |
| `autoMemoryDirectory` | string | Custom auto-memory storage path | -- |
| `autoMode` | object | Auto mode classifier rules (`{environment, allow, soft_deny}`) | -- |
| `autoUpdatesChannel` | string | `"stable"` or `"latest"` (default) | `"latest"` |
| `availableModels` | array | Restrict model picker (`["sonnet","haiku"]`) | -- |
| `cleanupPeriodDays` | number | Session cleanup after N days (default: 30) | -- |
| `defaultShell` | string | `"bash"` or `"powershell"` | -- |
| `effortLevel` | string | `"low"`, `"medium"`, `"high"` | `"high"` |
| `enabledPlugins` | object | Plugin enable/disable map | 8 plugins |
| `env` | object | Environment variables for all sessions | 2 vars |
| `extraKnownMarketplaces` | object | Additional plugin marketplace sources | -- |
| `fileSuggestion` | object | Custom `@` autocomplete script | -- |
| `hooks` | object | Lifecycle hook definitions | 4 hooks |
| `includeGitInstructions` | bool | Include git workflow in system prompt (default: true) | -- |
| `language` | string | Response language (`"japanese"`, etc.) | -- |
| `model` | string | Default model override | -- |
| `modelOverrides` | object | Map model IDs to provider-specific IDs | -- |
| `outputStyle` | string | Output style name or custom path | `"default"` (local) |
| `permissions` | object | Allow/ask/deny rules + defaultMode | configured |
| `plansDirectory` | string | Where plan files are stored | -- |
| `prefersReducedMotion` | bool | Reduce UI animations for accessibility | -- |
| `respectGitignore` | bool | `@` picker respects .gitignore (default: true) | -- |
| `showClearContextOnPlanAccept` | bool | Show clear context on plan accept | -- |
| `showThinkingSummaries` | bool | Show thinking summaries in interactive mode | -- |
| `spinnerTipsEnabled` | bool | Show spinner tips (default: true) | -- |
| `spinnerTipsOverride` | object | Custom spinner tips `{tips[], excludeDefault}` | -- |
| `spinnerVerbs` | object | Custom spinner verbs `{mode, verbs[]}` | -- |
| `statusLine` | object | Custom status line command | configured |
| `voiceEnabled` | bool | Push-to-talk voice dictation | `true` |
| `autoDreamEnabled` | bool | Auto memory consolidation between sessions | `true` |
| `skipDangerousModePermissionPrompt` | bool | Skip bypass mode confirmation | `true` |
| `teammateMode` | string | `"auto"`, `"in-process"`, `"tmux"` | `"in-process"` |

### Managed-Only Settings (Enterprise/Admin)

| Key | Description |
|-----|-------------|
| `allowedChannelPlugins` | Allowlist of channel plugins |
| `allowedHttpHookUrls` | Allowlist URL patterns for HTTP hooks |
| `allowedMcpServers` | Allowlist of MCP servers |
| `allowManagedHooksOnly` | Block non-managed hooks |
| `allowManagedMcpServersOnly` | Only admin MCP servers |
| `allowManagedPermissionRulesOnly` | Only admin permission rules |
| `blockedMarketplaces` | Blocklist of marketplace sources |
| `channelsEnabled` | Enable channels for Team/Enterprise |
| `companyAnnouncements` | Startup announcements |
| `deniedMcpServers` | Denylist of MCP servers |
| `disableAllHooks` | Disable all hooks and statusline |
| `disableAutoMode` | `"disable"` to block auto mode |
| `disableBypassPermissionsMode` | Block bypass mode |
| `disableDeepLinkRegistration` | Block `claude-cli://` registration |
| `disableSkillShellExecution` | Block `!command` in skills |
| `disabledMcpjsonServers` | Reject specific .mcp.json servers |
| `enableAllProjectMcpServers` | Auto-approve project MCP servers |
| `enabledMcpjsonServers` | Approve specific .mcp.json servers |
| `fastModePerSessionOptIn` | Require /fast each session |
| `feedbackSurveyRate` | Survey probability 0-1 |
| `forceLoginMethod` | `"claudeai"` or `"console"` |
| `forceLoginOrgUUID` | Require specific org UUID |
| `forceRemoteSettingsRefresh` | Block startup until settings fetched |
| `httpHookAllowedEnvVars` | Env var allowlist for HTTP hooks |
| `pluginTrustMessage` | Custom plugin trust warning |
| `strictKnownMarketplaces` | Marketplace allowlist |
| `useAutoModeDuringPlan` | Plan uses auto mode (default: true) |

### Permission Settings

| Key | Description |
|-----|-------------|
| `permissions.allow` | Array of allow rules |
| `permissions.ask` | Array of ask rules |
| `permissions.deny` | Array of deny rules |
| `permissions.additionalDirectories` | Extra working dirs |
| `permissions.defaultMode` | Default permission mode |
| `permissions.disableBypassPermissionsMode` | Block bypass |
| `permissions.skipDangerousModePermissionPrompt` | Skip confirmation |

### Sandbox Settings (under `sandbox.*`)

| Key | Description |
|-----|-------------|
| `sandbox.enabled` | Enable bash sandboxing |
| `sandbox.failIfUnavailable` | Exit if sandbox unavailable |
| `sandbox.autoAllowBashIfSandboxed` | Auto-approve bash in sandbox (default: true) |
| `sandbox.excludedCommands` | Commands that run outside sandbox |
| `sandbox.allowUnsandboxedCommands` | Allow dangerouslyDisableSandbox param |
| `sandbox.filesystem.allowWrite` | Additional writable paths |
| `sandbox.filesystem.denyWrite` | Non-writable paths |
| `sandbox.filesystem.denyRead` | Non-readable paths |
| `sandbox.filesystem.allowRead` | Re-allow read within denyRead |
| `sandbox.filesystem.allowManagedReadPathsOnly` | Only managed read paths |
| `sandbox.network.allowUnixSockets` | Allowed Unix socket paths |
| `sandbox.network.allowAllUnixSockets` | Allow all sockets |
| `sandbox.network.allowLocalBinding` | Allow localhost binding (macOS) |
| `sandbox.network.allowedDomains` | Allowed outbound domains |
| `sandbox.network.allowManagedDomainsOnly` | Only managed domains |
| `sandbox.network.httpProxyPort` | Custom HTTP proxy port |
| `sandbox.network.socksProxyPort` | Custom SOCKS5 proxy port |
| `sandbox.enableWeakerNestedSandbox` | For Docker environments |
| `sandbox.enableWeakerNetworkIsolation` | Allow TLS trust (macOS) |

### Worktree Settings (under `worktree.*`)

| Key | Description |
|-----|-------------|
| `worktree.symlinkDirectories` | Dirs to symlink into worktrees |
| `worktree.sparsePaths` | Sparse checkout paths |

### Global Config (~/.claude.json, NOT settings.json)

| Key | Description |
|-----|-------------|
| `autoConnectIde` | Auto-connect to running IDE |
| `autoInstallIdeExtension` | Auto-install IDE extension (default: true) |
| `editorMode` | `"normal"` or `"vim"` |
| `showTurnDuration` | Show turn duration (default: true) |
| `terminalProgressBarEnabled` | Terminal progress bar (default: true) |
| `teammateMode` | Agent team display mode |

---

## 2. Environment Variables

### API & Authentication (12 vars)

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_API_KEY` | API key for Anthropic |
| `ANTHROPIC_AUTH_TOKEN` | Custom Authorization Bearer token |
| `ANTHROPIC_BETAS` | Comma-separated beta headers |
| `ANTHROPIC_CUSTOM_HEADERS` | Custom request headers |
| `ANTHROPIC_FOUNDRY_API_KEY` | Microsoft Foundry key |
| `ANTHROPIC_FOUNDRY_BASE_URL` | Foundry base URL |
| `ANTHROPIC_FOUNDRY_RESOURCE` | Foundry resource name |
| `CLAUDE_CODE_OAUTH_REFRESH_TOKEN` | OAuth refresh token |
| `CLAUDE_CODE_OAUTH_SCOPES` | OAuth scopes |
| `CLAUDE_CODE_OAUTH_TOKEN` | OAuth access token |
| `AWS_BEARER_TOKEN_BEDROCK` | Bedrock API key |
| `CLAUDE_CODE_SKIP_BEDROCK_AUTH` / `_FOUNDRY_AUTH` / `_MANTLE_AUTH` / `_VERTEX_AUTH` | Skip auth |

### Base URLs (5 vars)

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_BASE_URL` | Override API endpoint |
| `ANTHROPIC_BEDROCK_BASE_URL` | Override Bedrock endpoint |
| `ANTHROPIC_BEDROCK_MANTLE_BASE_URL` | Override Bedrock Mantle |
| `ANTHROPIC_VERTEX_BASE_URL` | Override Vertex AI endpoint |
| `CLAUDE_CODE_IDE_HOST_OVERRIDE` | Override IDE host address |

### Model Configuration (16 vars)

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_MODEL` | Override model selection |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | Custom Haiku model ID |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | Custom Opus model ID |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | Custom Sonnet model ID |
| `ANTHROPIC_DEFAULT_*_MODEL_NAME` | Display name for pinned model |
| `ANTHROPIC_DEFAULT_*_MODEL_DESCRIPTION` | Description for pinned model |
| `ANTHROPIC_DEFAULT_*_MODEL_SUPPORTED_CAPABILITIES` | Capability flags |
| `ANTHROPIC_CUSTOM_MODEL_OPTION` | Custom entry in /model picker |
| `ANTHROPIC_CUSTOM_MODEL_OPTION_NAME` | Display name for custom model |
| `ANTHROPIC_CUSTOM_MODEL_OPTION_DESCRIPTION` | Description for custom model |
| `ANTHROPIC_SMALL_FAST_MODEL` | (Deprecated) Haiku-class model |
| `ANTHROPIC_SMALL_FAST_MODEL_AWS_REGION` | AWS region override for Haiku |
| `CLAUDE_CODE_SUBAGENT_MODEL` | Model for subagents |

### Thinking & Effort (5 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING` | Revert to fixed thinking budget |
| `CLAUDE_CODE_DISABLE_THINKING` | Force-disable extended thinking |
| `CLAUDE_CODE_EFFORT_LEVEL` | `low`/`medium`/`high`/`max`/`auto` |
| `MAX_THINKING_TOKENS` | Max thinking token budget |
| `DISABLE_INTERLEAVED_THINKING` | Disable interleaved thinking header |

### Prompt Caching (5 vars)

| Variable | Purpose |
|----------|---------|
| `DISABLE_PROMPT_CACHING` | Disable all caching |
| `DISABLE_PROMPT_CACHING_HAIKU` | Disable Haiku caching |
| `DISABLE_PROMPT_CACHING_OPUS` | Disable Opus caching |
| `DISABLE_PROMPT_CACHING_SONNET` | Disable Sonnet caching |
| `ENABLE_PROMPT_CACHING_1H_BEDROCK` | 1-hour cache TTL on Bedrock |

### Output & Token Limits (3 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_MAX_OUTPUT_TOKENS` | Max output tokens |
| `CLAUDE_CODE_FILE_READ_MAX_OUTPUT_TOKENS` | File read token limit |
| `BASH_MAX_OUTPUT_LENGTH` | Max bash output characters |

### Timeouts (10 vars)

| Variable | Default | Purpose |
|----------|---------|---------|
| `API_TIMEOUT_MS` | 600000 | API request timeout |
| `BASH_DEFAULT_TIMEOUT_MS` | 120000 | Bash command timeout |
| `BASH_MAX_TIMEOUT_MS` | 600000 | Max bash timeout |
| `CLAUDE_CODE_MAX_RETRIES` | 10 | API retry count |
| `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` | 1500 | SessionEnd hook timeout |
| `CLAUDE_CODE_PLUGIN_GIT_TIMEOUT_MS` | 120000 | Plugin git timeout |
| `CLAUDE_CODE_GLOB_TIMEOUT_SECONDS` | 20-60 | Glob tool timeout |
| `CLAUDE_STREAM_IDLE_TIMEOUT_MS` | 90000 | Stream watchdog timeout |
| `CLAUDE_CODE_OTEL_FLUSH_TIMEOUT_MS` | 5000 | OTel flush timeout |
| `CLAUDE_CODE_OTEL_SHUTDOWN_TIMEOUT_MS` | 2000 | OTel shutdown timeout |

### Context & Compaction (4 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` | Auto-compaction trigger % (default ~95) |
| `CLAUDE_CODE_AUTO_COMPACT_WINDOW` | Context capacity in tokens |
| `DISABLE_AUTO_COMPACT` | Disable auto-compaction |
| `DISABLE_COMPACT` | Disable all compaction |

### Memory (3 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_DISABLE_AUTO_MEMORY` | Disable auto memory |
| `CLAUDE_CODE_DISABLE_CLAUDE_MDS` | Don't load CLAUDE.md files |
| `CLAUDE_CODE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD` | Load CLAUDE.md from --add-dir |

### File Operations (5 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_DISABLE_ATTACHMENTS` | Disable attachments |
| `CLAUDE_CODE_GLOB_HIDDEN` | Include dotfiles in Glob |
| `CLAUDE_CODE_GLOB_NO_IGNORE` | Respect .gitignore in Glob |
| `CLAUDE_CODE_DISABLE_FILE_CHECKPOINTING` | Disable /rewind checkpoints |
| `CLAUDE_CODE_BASH_MAINTAIN_PROJECT_WORKING_DIR` | Stay in project dir after Bash |

### Shell & Environment (5 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_SHELL` | Override shell detection |
| `CLAUDE_CODE_SHELL_PREFIX` | Command prefix wrapper |
| `CLAUDE_CODE_TMPDIR` | Override temp directory |
| `CLAUDECODE` | Set to `1` in spawned shells |
| `CLAUDE_ENV_FILE` | Shell script sourced before Bash |

### UI & Display (8 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_DISABLE_MOUSE` | Disable mouse tracking |
| `CLAUDE_CODE_NO_FLICKER` | Flicker-free alt-screen rendering (NEW) |
| `CLAUDE_CODE_SCROLL_SPEED` | Mouse wheel multiplier (1-20) |
| `CLAUDE_CODE_DISABLE_TERMINAL_TITLE` | Disable terminal title |
| `CLAUDE_CODE_CODE_ACCESSIBILITY` | Keep native cursor visible |
| `CLAUDE_CODE_SYNTAX_HIGHLIGHT` | `false` to disable syntax highlighting |
| `CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION` | `false` to disable prompt suggestions |
| `SLASH_COMMAND_TOOL_CHAR_BUDGET` | Skill description budget (default: 1% of context, min 8000) |

### Tasks & Background (5 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_ENABLE_TASKS` | Enable tasks in non-interactive mode |
| `CLAUDE_CODE_AUTO_BACKGROUND_TASKS` | Force auto-backgrounding |
| `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS` | Disable background tasks |
| `CLAUDE_CODE_TASK_LIST_ID` | Share task list across sessions |
| `CLAUDE_CODE_MAX_TOOL_USE_CONCURRENCY` | Max parallel tools (default: 10) |

### Experimental / Feature Flags (3 vars)

| Variable | Purpose | Status |
|----------|---------|--------|
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | Enable agent teams | Experimental |
| `CLAUDE_CODE_TEAM_NAME` | Team name for teammate | Experimental |
| `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS` | Disable beta headers (for Bedrock/Vertex) | Stable |

### Plugins (6 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_PLUGIN_CACHE_DIR` | Override plugins root dir |
| `CLAUDE_CODE_PLUGIN_SEED_DIR` | Read-only plugin seed dirs |
| `CLAUDE_CODE_PLUGIN_KEEP_MARKETPLACE_ON_FAILURE` | Keep cache on git fail |
| `CLAUDE_CODE_DISABLE_OFFICIAL_MARKETPLACE_AUTOINSTALL` | Skip official marketplace |
| `CLAUDE_CODE_SYNC_PLUGIN_INSTALL` | Wait for plugin install |
| `CLAUDE_CODE_SYNC_PLUGIN_INSTALL_TIMEOUT_MS` | Plugin install timeout |

### MCP (3 vars)

| Variable | Purpose |
|----------|---------|
| `ENABLE_TOOL_SEARCH` | Enable MCP tool search with proxy |
| `CLAUDE_AGENT_SDK_MCP_NO_PREFIX` | Skip mcp__ prefix on tool names |
| `ENABLE_CLAUDEAI_MCP_SERVERS` | Enable claude.ai MCP servers |

### Windows-Specific (2 vars)

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CODE_GIT_BASH_PATH` | Path to Git Bash |
| `CLAUDE_CODE_USE_POWERSHELL_TOOL` | Enable PowerShell tool |

### Other Notable Variables

| Variable | Purpose |
|----------|---------|
| `CLAUDE_CONFIG_DIR` | Override config dir (default: ~/.claude) |
| `CLAUDE_CODE_DISABLE_1M_CONTEXT` | Disable 1M context window |
| `CLAUDE_CODE_DISABLE_CRON` | Disable scheduled tasks |
| `CLAUDE_CODE_DISABLE_FAST_MODE` | Disable fast mode |
| `CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS` | Remove git instructions from prompt |
| `CLAUDE_CODE_NEW_INIT` | Interactive /init setup flow |
| `CLAUDE_CODE_SIMPLE` | Minimal system prompt + core tools |
| `CLAUDE_CODE_RESUME_INTERRUPTED_TURN` | Auto-resume interrupted sessions |
| `CLAUDE_CODE_EXIT_AFTER_STOP_DELAY` | Auto-exit after idle (ms) |
| `DISABLE_TELEMETRY` | Opt out of Statsig |
| `DISABLE_ERROR_REPORTING` | Opt out of Sentry |
| `DISABLE_AUTOUPDATER` | Disable auto-updates |
| `CLAUDE_CODE_ENABLE_TELEMETRY` | Enable OpenTelemetry |
| `CLAUDE_CODE_DEBUG_LOGS_DIR` | Debug log path |
| `CLAUDE_CODE_DEBUG_LOG_LEVEL` | `verbose`/`debug`/`info`/`warn`/`error` |
| `CLAUDE_REMOTE_CONTROL_SESSION_NAME_PREFIX` | Remote Control session prefix |
| `ENABLE_LSP_TOOL` | Enable LSP integration tool | 

---

## 3. CLI Launch Flags

| Flag | Short | Purpose |
|------|-------|---------|
| `--add-dir <path>` | | Add working directories |
| `--agent <name>` | | Use a named subagent |
| `--agents <json>` | | Define subagents dynamically |
| `--allow-dangerously-skip-permissions` | | Add bypass to Shift+Tab cycle |
| `--allowedTools <rules>` | | Pre-approve tools |
| `--append-system-prompt <text>` | | Append to system prompt |
| `--append-system-prompt-file <path>` | | Append file to system prompt |
| `--bare` | | Minimal mode, skip auto-discovery |
| `--betas <list>` | | Beta headers for API |
| `--channels <list>` | | Channel MCP servers to listen for |
| `--chrome` | | Enable Chrome browser integration |
| `--continue` | `-c` | Continue most recent conversation |
| `--dangerously-load-development-channels` | | Load unapproved channels |
| `--dangerously-skip-permissions` | | Skip all permission prompts |
| `--debug [categories]` | | Enable debug logging |
| `--debug-file <path>` | | Write debug to specific file |
| `--disable-slash-commands` | | Disable all skills/commands |
| `--disallowedTools <tools>` | | Remove tools from context |
| `--effort <level>` | | Set effort level for session |
| `--enable-auto-mode` | | Unlock auto mode |
| `--fallback-model <model>` | | Fallback model when overloaded |
| `--fork-session` | | New session ID on resume |
| `--from-pr <number>` | | Resume sessions linked to PR |
| `--ide` | | Auto-connect to IDE |
| `--init` | | Run init hooks + interactive |
| `--init-only` | | Run init hooks + exit |
| `--include-hook-events` | | Include hooks in output stream |
| `--include-partial-messages` | | Include partial streaming events |
| `--input-format <format>` | | Input format: `text`, `stream-json` |
| `--json-schema <schema>` | | Structured output (print mode) |
| `--maintenance` | | Run maintenance hooks + interactive |
| `--max-budget-usd <amount>` | | Max spend (print mode) |
| `--max-turns <n>` | | Max agentic turns (print mode) |
| `--mcp-config <path>` | | Load MCP from JSON files |
| `--model <alias>` | | Set model (opus, sonnet, haiku, etc.) |
| `--name` | `-n` | Name the session |
| `--no-chrome` | | Disable Chrome integration |
| `--no-session-persistence` | | Don't save session (print mode) |
| `--output-format <format>` | | `text`, `json`, `stream-json` |
| `--permission-mode <mode>` | | Set permission mode |
| `--permission-prompt-tool <mcp>` | | MCP tool for permission prompts |
| `--plugin-dir <path>` | | Load plugins from directory |
| `--print` | `-p` | Non-interactive query + exit |
| `--remote <task>` | | Create web session on claude.ai |
| `--remote-control` | `--rc` | Start Remote Control server |
| `--replay-user-messages` | | Re-emit user messages to stdout |
| `--resume` | `-r` | Resume session by ID or name |
| `--session-id <uuid>` | | Use specific session UUID |
| `--setting-sources <list>` | | Which settings to load |
| `--settings <path>` | | Additional settings file |
| `--strict-mcp-config` | | Only use --mcp-config servers |
| `--system-prompt <text>` | | Replace entire system prompt |
| `--system-prompt-file <path>` | | Replace prompt from file |
| `--teleport` | | Resume web session locally |
| `--teammate-mode <mode>` | | `auto`/`in-process`/`tmux` |
| `--tmux` | | Create tmux session for worktree |
| `--tools <list>` | | Restrict available tools |
| `--verbose` | | Verbose logging |
| `--version` | `-v` | Show version |
| `--worktree` | `-w` | Start in isolated git worktree |

---

## 4. Permission Modes

| Mode | What runs without asking | Activation |
|------|------------------------|------------|
| `default` | Reads only | Default, `Shift+Tab` |
| `acceptEdits` | Reads + file edits | `Shift+Tab` or `--permission-mode acceptEdits` |
| `plan` | Reads only (no edits) | `Shift+Tab` or `/plan` or `--permission-mode plan` |
| `auto` | Everything (with classifier) | `--enable-auto-mode` then `Shift+Tab`. Requires Team/Enterprise/API, Sonnet 4.6 or Opus 4.6, Anthropic API only. **Research preview.** |
| `dontAsk` | Only pre-approved tools | `--permission-mode dontAsk` |
| `bypassPermissions` | Everything except protected paths | `--dangerously-skip-permissions` or `--permission-mode bypassPermissions` |

**Auto mode classifier blocks by default**: curl | bash, sending data to external endpoints, production deploys, mass deletion, IAM changes, force push to main.

**Protected paths (never auto-approved)**: `.git`, `.vscode`, `.idea`, `.husky`, `.claude` (except commands/agents/skills/worktrees), `.gitconfig`, `.gitmodules`, `.bashrc`, `.zshrc`, `.profile`, `.mcp.json`, `.claude.json`.

### Permission Rule Syntax

```
Tool                    - matches all uses
Tool(specifier)         - matches specific pattern
Bash(npm run *)         - wildcard bash
Read(./.env)            - specific file
Read(./secrets/**)      - recursive glob
WebFetch(domain:x.com)  - domain filter
Skill(deploy *)         - skill prefix match
Agent(reviewer)         - specific subagent
```

**Evaluation order**: deny first, then ask, then allow. First match wins.

---

## 5. Hooks - All 26 Lifecycle Events

**Handler types**: `command` (shell), `http` (POST endpoint), `prompt` (single-turn LLM), `agent` (subagent with tools)

**Exit codes**: 0 = success, 2 = blocking error, other = non-blocking

### Session Lifecycle

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 1 | `SessionStart` | Session begins/resumes | No | `startup`, `resume`, `clear`, `compact` |
| 2 | `SessionEnd` | Session terminates | No | `clear`, `resume`, `logout`, `prompt_input_exit`, etc. |

### User Input

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 3 | `UserPromptSubmit` | Prompt submitted, before processing | Yes (`decision: "block"`) | None |

### Tool Lifecycle

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 4 | `PreToolUse` | Before tool executes | Yes (allow/deny/ask/defer + modify input) | Tool names: `Bash`, `Edit`, `Write`, `Read`, `Glob`, `Grep`, `Agent`, `WebFetch`, `WebSearch`, `AskUserQuestion`, `ExitPlanMode`, `mcp__*` |
| 5 | `PermissionRequest` | Permission dialog about to show | Yes (allow/deny + update rules) | Tool names |
| 6 | `PermissionDenied` | Auto mode classifier denies call | Yes (`retry: true`) | Tool names |
| 7 | `PostToolUse` | After tool succeeds | Yes (`decision: "block"`) | Tool names |
| 8 | `PostToolUseFailure` | After tool fails | No (context only) | Tool names |

### Agent Lifecycle

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 9 | `SubagentStart` | Subagent spawned | No (inject context) | Agent type names |
| 10 | `SubagentStop` | Subagent finishes | Yes (`decision: "block"`) | Agent type names |

### Response Lifecycle

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 11 | `Stop` | Claude finishes responding | Yes (`decision: "block"` to continue) | None |
| 12 | `StopFailure` | Turn ends due to API error | No (logging only) | Error type: `rate_limit`, `authentication_failed`, `billing_error`, `invalid_request`, `server_error`, `max_output_tokens`, `unknown` |

### Task Management

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 13 | `TaskCreated` | Task being created | Yes (exit 2 blocks) | None |
| 14 | `TaskCompleted` | Task being completed | Yes (exit 2 blocks) | None |
| 15 | `TeammateIdle` | Teammate about to go idle | Yes (exit 2 keeps working) | None |

### Context & Configuration

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 16 | `InstructionsLoaded` | CLAUDE.md/rules loaded | No (observability) | `session_start`, `nested_traversal`, `path_glob_match`, `include`, `compact` |
| 17 | `ConfigChange` | Config file changes mid-session | Yes (except policy) | `user_settings`, `project_settings`, `local_settings`, `policy_settings`, `skills` |
| 18 | `PreCompact` | Before context compaction | No | `manual`, `auto` |
| 19 | `PostCompact` | After compaction completes | No | `manual`, `auto` |

### File & Directory

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 20 | `CwdChanged` | Working directory changes | No | None |
| 21 | `FileChanged` | Watched file changes on disk | No | Filename (basename) |

### Worktree

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 22 | `WorktreeCreate` | Worktree being created | Yes (custom path) | None |
| 23 | `WorktreeRemove` | Worktree being removed | No | None |

### MCP Elicitation

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 24 | `Elicitation` | MCP server requests user input | Yes (accept/decline/cancel) | MCP server name |
| 25 | `ElicitationResult` | User responds to MCP elicitation | Yes (override values) | MCP server name |

### Notification

| # | Event | When | Can Block? | Matcher |
|---|-------|------|------------|---------|
| 26 | `Notification` | Claude sends notification | No | `permission_prompt`, `idle_prompt`, `auth_success`, `elicitation_dialog` |

### YOUR CURRENT HOOKS vs AVAILABLE

| Event | You Have | Available But Not Using |
|-------|----------|------------------------|
| PreToolUse | YES (Bash only) | All other tool matchers |
| PostToolUse | YES (Bash only) | All other tool matchers |
| TeammateIdle | YES | -- |
| TaskCompleted | YES | -- |
| SessionStart | NO | **Add for context loading** |
| UserPromptSubmit | NO | **Add for prompt validation** |
| PermissionRequest | NO | **Auto-approve patterns** |
| PermissionDenied | NO | **Retry logic for auto mode** |
| PostToolUseFailure | NO | **Failure recovery** |
| SubagentStart | NO | **Inject context into subagents** |
| SubagentStop | NO | **Verify subagent output** |
| Stop | NO | **Force continuation** |
| StopFailure | NO | **Error logging** |
| TaskCreated | NO | **Task validation** |
| InstructionsLoaded | NO | **Audit logging** |
| ConfigChange | NO | **Config change detection** |
| PreCompact/PostCompact | NO | **Compaction logging** |
| CwdChanged | NO | **Directory-reactive env** |
| FileChanged | NO | **Watch .env changes** |
| WorktreeCreate/Remove | NO | **Custom worktree paths** |
| Elicitation/ElicitationResult | NO | **MCP input automation** |
| Notification | NO | **Custom notifications** |
| SessionEnd | NO | **Cleanup/logging** |

---

## 6. Built-in Slash Commands

| Command | Purpose | Notes |
|---------|---------|-------|
| `/add-dir <path>` | Add working directory | Session-scoped |
| `/agents` | Manage subagent configs | |
| `/btw <question>` | Side question (no context) | |
| `/chrome` | Configure Chrome integration | |
| `/clear` | Clear conversation | Aliases: `/reset`, `/new` |
| `/color [color]` | Set prompt bar color | red/blue/green/yellow/purple/orange/pink/cyan |
| `/compact [instructions]` | Compress conversation | Optional focus |
| `/config` | Open Settings interface | Alias: `/settings` |
| `/context` | Visualize context usage grid | |
| `/copy [N]` | Copy response to clipboard | Interactive block picker |
| `/cost` | Show token usage stats | Per-model breakdown |
| `/desktop` | Continue in Desktop app | Alias: `/app` |
| `/diff` | Interactive diff viewer | Git diff + per-turn diffs |
| `/effort [level]` | Set effort level | `low`/`medium`/`high`/`max`/`auto` |
| `/exit` | Exit CLI | Alias: `/quit` |
| `/export [filename]` | Export conversation as text | |
| `/extra-usage` | Configure extra usage | |
| `/fast [on\|off]` | Toggle fast mode | |
| `/feedback [report]` | Submit feedback | Alias: `/bug` |
| `/branch [name]` | Branch conversation | Alias: `/fork` |
| `/help` | Show help | |
| `/hooks` | View hook configurations | |
| `/ide` | Manage IDE integrations | |
| `/init` | Initialize project CLAUDE.md | Set `CLAUDE_CODE_NEW_INIT=1` for interactive |
| `/insights` | Session analysis report | |
| `/install-github-app` | Setup GitHub Actions | |
| `/install-slack-app` | Install Slack app | |
| `/keybindings` | Open keybindings config | |
| `/login` | Sign in | |
| `/logout` | Sign out | |
| `/mcp` | Manage MCP servers + OAuth | |
| `/memory` | Edit CLAUDE.md, auto-memory | |
| `/mobile` | QR code for mobile app | Aliases: `/ios`, `/android` |
| `/model [model]` | Switch model | Left/right for effort |
| `/passes` | Share free week | Account-dependent |
| `/permissions` | Manage allow/ask/deny rules | Alias: `/allowed-tools` |
| `/plan [description]` | Enter plan mode | |
| `/plugin` | Manage plugins | |
| `/powerup` | Interactive feature lessons | |
| `/privacy-settings` | Privacy controls | Pro/Max only |
| `/release-notes` | Interactive changelog | |
| `/reload-plugins` | Reload active plugins | |
| `/remote-control` | Enable Remote Control | Alias: `/rc` |
| `/remote-env` | Configure remote environment | |
| `/rename [name]` | Rename session | |
| `/resume [session]` | Resume by ID/name | Alias: `/continue` |
| `/rewind` | Rewind conversation/code | Alias: `/checkpoint` |
| `/sandbox` | Toggle sandbox mode | |
| `/schedule [desc]` | Manage cloud scheduled tasks | |
| `/security-review` | Analyze branch for vulns | |
| `/setup-bedrock` | Bedrock config wizard | |
| `/skills` | List available skills | |
| `/stats` | Usage visualizations | |
| `/status` | Show version/model/account | Works mid-response |
| `/statusline` | Configure status line | |
| `/stickers` | Order stickers | |
| `/tasks` | Manage background tasks | Alias: `/bashes` |
| `/terminal-setup` | Configure terminal keybindings | |
| `/theme` | Change color theme | Light/dark/colorblind/ANSI |
| `/ultraplan <prompt>` | Cloud plan + browser review | |
| `/upgrade` | Upgrade plan tier | |
| `/usage` | Plan limits + rate status | |
| `/voice` | Toggle voice dictation | |

---

## 7. Bundled Skills

| Skill | Purpose | Activation |
|-------|---------|------------|
| `/batch <instruction>` | Parallel codebase changes across worktrees (5-30 units) | `/batch migrate src/ from Solid to React` |
| `/claude-api` | Load Claude API/SDK reference material | Also auto-triggers on `anthropic` imports |
| `/debug [description]` | Enable debug logging + troubleshoot | `/debug` or `/debug my issue` |
| `/loop [interval] <prompt>` | Run prompt on recurring interval | `/loop 5m check deploy status` |
| `/simplify [focus]` | Review changed files for quality (3 parallel agents) | `/simplify focus on memory efficiency` |

---

## 8. Official Plugins Marketplace

Install: `/plugin install <name>@claude-plugins-official`

### Internal Plugins (32 - Anthropic developed)

| Plugin | Category | Description |
|--------|----------|-------------|
| `agent-sdk-dev` | Development | Agent SDK development tools |
| `clangd-lsp` | LSP | C/C++ language server |
| `claude-code-setup` | Config | Project setup wizard |
| `claude-md-management` | Config | CLAUDE.md management |
| `code-review` | Code Quality | PR code review (/code-review) |
| `code-simplifier` | Code Quality | Code simplification (/simplify) |
| `commit-commands` | Git | Git commit commands |
| `csharp-lsp` | LSP | C# language server |
| `example-plugin` | Demo | Example plugin template |
| `explanatory-output-style` | Output Style | Explanatory response style |
| `feature-dev` | Development | Guided feature development |
| `frontend-design` | Design | Production-grade frontend UI |
| `gopls-lsp` | LSP | Go language server |
| `hookify` | Config | Hook creation assistant |
| `jdtls-lsp` | LSP | Java language server |
| `kotlin-lsp` | LSP | Kotlin language server |
| `learning-output-style` | Output Style | Learning/educational style |
| `lua-lsp` | LSP | Lua language server |
| `math-olympiad` | Reasoning | Math problem solving |
| `mcp-server-dev` | Development | MCP server development |
| `php-lsp` | LSP | PHP language server |
| `playground` | Demo | Plugin development playground |
| `plugin-dev` | Development | Plugin development tools |
| `pr-review-toolkit` | Code Quality | PR review toolkit |
| `pyright-lsp` | LSP | Python language server |
| `ralph-loop` | Automation | Interactive AI loops |
| `ruby-lsp` | LSP | Ruby language server |
| `rust-analyzer-lsp` | LSP | Rust language server |
| `security-guidance` | Security | Security analysis |
| `skill-creator` | Development | Skill creation assistant |
| `swift-lsp` | LSP | Swift language server |
| `typescript-lsp` | LSP | TypeScript language server |

### External Plugins (17 - Third-party/Partner)

| Plugin | Category | Description |
|--------|----------|-------------|
| `asana` | Project Mgmt | Asana integration |
| `context7` | Context | Up-to-date library docs |
| `discord` | Channel | Discord messaging channel |
| `fakechat` | Testing | Fake chat for testing |
| `firebase` | Cloud | Firebase integration |
| `github` | Git | GitHub MCP server (issues, PRs) |
| `gitlab` | Git | GitLab integration |
| `greptile` | Search | Codebase search |
| `imessage` | Channel | iMessage channel |
| `laravel-boost` | Framework | Laravel development |
| `linear` | Project Mgmt | Linear integration |
| `playwright` | Testing | Browser automation |
| `serena` | Assistant | AI coding assistant |
| `slack` | Channel | Slack integration |
| `supabase` | Cloud | Supabase integration |
| `telegram` | Channel | Telegram channel |
| `terraform` | Infrastructure | Terraform tools |

### YOUR PLUGINS vs AVAILABLE

**You have**: superpowers, context7, code-review, code-simplifier, frontend-design, github, playwright, security-guidance (8)

**Missing and potentially useful**:
- `hookify` -- Hook creation assistant
- `skill-creator` -- Skill creation tools
- `commit-commands` -- Git commit workflow
- `feature-dev` -- Guided feature development
- `pr-review-toolkit` -- PR review toolkit
- `claude-code-setup` -- Project setup
- `claude-md-management` -- CLAUDE.md management
- `typescript-lsp` -- TypeScript LSP (if doing TS work)
- `pyright-lsp` -- Python LSP
- `telegram` -- Telegram channel (for mobile control)
- `discord` -- Discord channel
- `slack` -- Slack integration
- `linear` -- Linear project management
- `asana` -- Asana project management
- `ralph-loop` -- Interactive AI loops

---

## 9. Custom Skills

**Location**: `~/.claude/skills/<name>/SKILL.md` (user), `.claude/skills/<name>/SKILL.md` (project)

### Frontmatter Fields

| Field | Purpose |
|-------|---------|
| `name` | Slash command name (lowercase, hyphens) |
| `description` | When to use (250 char cap in listing) |
| `argument-hint` | Autocomplete hint |
| `disable-model-invocation` | Only manual `/name` invocation |
| `user-invocable` | `false` to hide from `/` menu |
| `allowed-tools` | Auto-approved tools |
| `model` | Model override for this skill |
| `effort` | Effort override |
| `context` | `fork` for subagent isolation |
| `agent` | Subagent type when `context: fork` |
| `hooks` | Skill-scoped hooks |
| `paths` | Glob patterns for auto-activation |
| `shell` | `bash` or `powershell` |

### String Substitutions

| Variable | Value |
|----------|-------|
| `$ARGUMENTS` | All arguments |
| `$ARGUMENTS[N]` / `$N` | Nth argument (0-based) |
| `${CLAUDE_SESSION_ID}` | Current session ID |
| `${CLAUDE_SKILL_DIR}` | Skill directory path |

### Dynamic Context

`` !`command` `` runs shell before sending to Claude. Fenced ` ```! ` for multi-line.

---

## 10. Custom Subagents

**Location**: `~/.claude/agents/<name>.md` (user), `.claude/agents/<name>.md` (project)

### Frontmatter Fields

| Field | Purpose |
|-------|---------|
| `description` | When to use this agent |
| `tools` | Allowed tools list |
| `disallowedTools` | Blocked tools |
| `model` | Model for this agent |
| `permissionMode` | Permission mode |
| `mcpServers` | MCP servers for this agent |
| `hooks` | Agent-scoped hooks |
| `maxTurns` | Max conversation turns |
| `skills` | Preloaded skills |
| `initialPrompt` | Starting prompt |
| `memory` | Memory configuration |
| `effort` | Effort level |
| `background` | Run in background |
| `isolation` | `"worktree"` for git worktree isolation |
| `color` | Session color |

Invoke with `@agent-name` in chat, or `--agent <name>` at startup.

---

## 11. Agent Teams

**Status**: Experimental (research preview)

**Enable**: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in settings.json `env` or shell

### How It Works

1. Enable the env var
2. Tell Claude in natural language to create a team
3. Claude spawns teammates, creates shared task list, coordinates

### Display Modes

| Mode | Setting | Description |
|------|---------|-------------|
| `auto` | Default | Picks split panes in tmux/iTerm2, in-process otherwise |
| `in-process` | `"teammateMode": "in-process"` | All in one terminal, Shift+Up/Down to switch |
| `tmux` | `"teammateMode": "tmux"` | Separate tmux panes |

### Controls

| Key | Action |
|-----|--------|
| Shift+Up/Down | Select teammate |
| Ctrl+T | View task list |
| Enter | View teammate session |
| Escape | Interrupt teammate |

### Tools Available

- `TeamCreate` -- Create agent team
- `TeamDelete` -- Delete team
- `TaskCreate` -- Create task
- `TaskGet` -- Get task details
- `TaskList` -- List tasks
- `TaskUpdate` -- Update task status
- `SendMessage` -- Message teammate

---

## 12. MCP Servers

**Configuration locations**:
- `~/.claude.json` -- User-scope MCP servers
- `.mcp.json` -- Project-scope MCP servers
- `managed-mcp.json` -- Enterprise managed

### Transport Types

| Type | Use Case |
|------|----------|
| `stdio` | Local processes (direct system access) |
| `http` | Remote servers (cloud services) |
| `sse` | Server-sent events |

### Configuration Format

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-name"],
      "env": { "KEY": "value" }
    }
  }
}
```

### Your MCP Servers

- `claude-in-chrome` -- Chrome browser control with 18+ tools

---

## 13. Model Configuration

### Available Model Aliases

| Alias | Resolves To | Notes |
|-------|-------------|-------|
| `default` | Plan-dependent | Clears override |
| `best` | = `opus` | Most capable |
| `sonnet` | Sonnet 4.6 | Daily coding |
| `opus` | Opus 4.6 | Complex reasoning |
| `haiku` | Haiku 4.5 | Fast/simple |
| `sonnet[1m]` | Sonnet 4.6 + 1M context | Long sessions |
| `opus[1m]` | Opus 4.6 + 1M context | Long sessions |
| `opusplan` | Opus for plan, Sonnet for execution | Hybrid |

### Setting Model (priority order)

1. `/model <alias>` during session
2. `claude --model <alias>` at startup
3. `ANTHROPIC_MODEL=<alias>` env var
4. `"model": "<alias>"` in settings.json

### Effort Levels

| Level | Persistence | Availability |
|-------|-------------|-------------|
| `low` | Across sessions | Opus 4.6, Sonnet 4.6 |
| `medium` | Across sessions | Opus 4.6, Sonnet 4.6 |
| `high` | Across sessions | Opus 4.6, Sonnet 4.6 |
| `max` | Current session only | Opus 4.6 only |
| `auto` | Resets to default | All |

Defaults: Pro/Max = medium. API/Team/Enterprise = high.

**"ultrathink"** in prompt = triggers high effort for that turn.

---

## 14. Context Window Management

- **1M context**: GA for Opus 4.6 and Sonnet 4.6. No pricing premium.
- **Auto-compaction**: Triggers at ~83.5% capacity (~33K token buffer reserved).
- **`/compact [instructions]`**: Manual compaction with optional focus.
- **`/context`**: Visual grid of context usage.
- **Disable**: `DISABLE_AUTO_COMPACT=1` or `DISABLE_COMPACT=1`.
- **Override**: `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` (1-100).

---

## 15. Voice Dictation

**Enable**: `/voice` or `"voiceEnabled": true` in settings.json

**Requirements**: Claude.ai account, local microphone, v2.1.69+

**How**: Hold `Space` to record, release to transcribe. Tuned for coding vocabulary.

**Rebind PTT key**: `~/.claude/keybindings.json` -- bind `voice:pushToTalk`

**Languages**: en, ja, ko, hi, fr, de, es, it, pt, ru, zh(implied), nl, pl, sv, tr, uk, cs, da, el, id, no (20 languages)

---

## 16. AutoDream / Memory

**Enable**: `"autoDreamEnabled": true` in settings.json

**What it does**: Background subagent that consolidates, prunes, and reorganizes memory files between sessions. Modeled after REM sleep memory consolidation.

- Merges duplicate memories
- Eliminates contradictions
- Resolves speculations
- Prunes for actionability

**Manual**: `/dream` -- trigger dream cycle manually

**Auto-memory**: `/memory` to manage. Files stored in `~/.claude/projects/<project>/memory/MEMORY.md`.

---

## 17. Computer Use

**Status**: Research preview (Pro and Max subscribers)

**What it does**: Claude captures screen, recognizes UI, sends mouse/keyboard commands. Works with native apps, mobile simulators, desktop tools without CLI.

**Platform**: macOS (March 2026), Windows (April 3, 2026)

**Enable**: Available automatically in Claude Code Desktop and Cowork for eligible subscribers.

---

## 18. Remote Control & Dispatch

### Remote Control

**Status**: Research preview (February 2026)

**What it does**: Bridges local Claude Code session with claude.ai/code, iOS app, Android app. Code stays local, only chat + tool results flow through encrypted bridge.

**Enable**: `claude remote-control --name "My Project"` or `/remote-control` in session

### Dispatch

**What it does**: Persistent conversation between Claude mobile app and desktop Cowork session. Phone = messaging layer, Mac = computation.

**Platform**: iOS, Android

### Web Sessions

**`claude --remote "Fix the login bug"`**: Creates web session on claude.ai

**`claude --teleport`**: Resume web session in local terminal

---

## 19. Scheduled Tasks / Loop / Cron

### Local Loop

**`/loop [interval] <prompt>`**: Recurring prompt within session.

- Units: `s` (seconds), `m` (minutes), `h` (hours), `d` (days)
- Max 50 tasks per session
- Auto-expire after 7 days
- Example: `/loop 5m check if deploy finished`

### Cloud Scheduled Tasks (Remote)

**`/schedule`**: Create cron-scheduled remote agents on Anthropic infrastructure.

- Runs autonomously in cloud (laptop not needed)
- Requires GitHub repo
- Use cases: overnight PR monitoring, automated fixes, morning summaries

### Tools Available

- `CronCreate` -- Create scheduled task
- `CronDelete` -- Delete scheduled task
- `CronList` -- List scheduled tasks
- `RemoteTrigger` -- Trigger remote execution

**Disable**: `CLAUDE_CODE_DISABLE_CRON=1`

---

## 20. Ultraplan

**Status**: Stable (launched April 2026)

**What it does**: Offloads planning to cloud (Opus 4.6, up to 30 min). Browser-based review interface with inline comments, emoji reactions, outline sidebar.

**Activate**:
- `/ultraplan <prompt>`
- Include "ultraplan" in any prompt
- Choose Ultraplan from plan approval dialog

**Execute**: From browser, choose cloud execution or send plan back to terminal.

**Requires**: Claude Code on the web account + GitHub repo.

---

## 21. Fast Mode

**Status**: Research preview

**What it does**: Opus 4.6 at 2.5x speed, higher cost per token. Same model, different API config.

**Enable**: `/fast` to toggle. Persists across sessions.

**Requires**: v2.1.36+, extra usage enabled. Team/Enterprise: admin must enable first.

**Billing**: Charged to extra usage from first token (bypasses plan limits).

**Disable globally**: `CLAUDE_CODE_DISABLE_FAST_MODE=1`

---

## 22. Channels

**Status**: Research preview (March 2026)

**Supported platforms**: Telegram, Discord, iMessage

**What it does**: Send messages from messaging apps into running Claude Code session. Full filesystem, MCP, git access. Replies through same app.

**Enable**: `claude --channels plugin:telegram@claude-plugins-official`

**Requires**: `channelsEnabled: true` in managed settings (Team/Enterprise), channel plugin installed.

**Not yet available**: Slack, WhatsApp (requested by community).

---

## 23. Git Worktrees

**Since**: v2.1.49 (February 2026)

**What it does**: Creates isolated working directories with own files and branch, sharing repo history.

**Activate**:
- `claude --worktree feature-auth` or `claude -w feature-auth`
- Ask Claude mid-session: "work in a worktree"
- Subagent frontmatter: `isolation: "worktree"`

**Settings**:
- `worktree.symlinkDirectories`: Dirs to symlink (e.g., `["node_modules"]`)
- `worktree.sparsePaths`: Sparse checkout paths
- `.worktreeinclude`: Copy gitignored files to worktrees

**Cleanup**: Automatic on session exit if no changes. `cleanupPeriodDays` controls orphan removal.

**Tools**: `EnterWorktree`, `ExitWorktree`

---

## 24. Sandboxing

**What it does**: Isolates bash commands from filesystem and network.

**Enable**: `"sandbox": { "enabled": true }` in settings.json

**Platforms**: macOS, Linux, WSL2

**Key features**:
- Auto-approve bash when sandboxed
- Filesystem allow/deny for read and write
- Network domain allowlist
- Excluded commands
- Unix socket control
- Proxy configuration

---

## 25. Deep Links

**Protocol**: `claude-cli://open?q=<url-encoded-prompt>`

**What it does**: External tools can open Claude Code with pre-filled prompt. Supports multi-line prompts.

**Disable**: `"disableDeepLinkRegistration": "disable"` in settings.json

---

## 26. Plugins System

**Marketplace**: `anthropics/claude-plugins-official` (auto-available)

**Commands**:
- `/plugin` -- Browse/install/manage
- `/plugin install <name>@<marketplace>`
- `/reload-plugins` -- Reload without restart

**Plugin components**: Skills, agents, hooks, MCP servers, commands, output styles

**Community marketplaces**: Can add via `extraKnownMarketplaces` setting or `claude plugin marketplace add`

---

## 27. Output Styles & Themes

**Output styles**: `/config` -> Output style. Custom styles via plugins (e.g., `explanatory-output-style`, `learning-output-style`).

**Themes**: `/theme` -- Light/dark, colorblind-accessible (daltonized), ANSI themes.

**Custom**: `"outputStyle"` in settings.json, or create custom output style skill.

---

## 28. Keybindings

**File**: `~/.claude/keybindings.json`

**Open**: `/keybindings`

**Format**:
```json
{
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "meta+k": "voice:pushToTalk",
        "ctrl+shift+c": "clipboard:copy"
      }
    }
  ]
}
```

**Supported**: Single keys, modifier combos, chord sequences. Auto-reload on save.

**Key shortcuts**:
- `Shift+Tab` -- Cycle permission modes
- `Alt+M` -- Toggle permission modes
- `Ctrl+F` (x2) -- Kill all background agents
- `Shift+Up/Down` -- Navigate teammates
- `Ctrl+T` -- Task list (teams)

---

## 29. Status Line

**Config**: `"statusLine"` in settings.json

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

**Configure**: `/statusline`

**Community tools**: claude-powerline, CCometixLine (Rust), claudia-statusline (Rust), ccstatusline

---

## 30. IDE Integration

**VS Code**: Auto-install extension, `/ide` to manage.

**JetBrains**: Plugin runs Claude Code in IDE terminal.

**Desktop app**: `/desktop` or `/app` to continue session.

**Settings**: `autoConnectIde`, `autoInstallIdeExtension` in `~/.claude.json`.

---

## 31. Gap Analysis - What You're Missing

### HIGH VALUE - Not in your setup

| Feature | What it does | How to activate |
|---------|-------------|-----------------|
| **Auto Mode** | AI classifier auto-approves safe actions | `claude --enable-auto-mode` (requires Team/Enterprise/API plan) |
| **Fast Mode** | 2.5x faster Opus responses | `/fast` (requires extra usage) |
| **Ultraplan** | Cloud planning with browser review | `/ultraplan <task>` |
| **Channels** | Control Claude from phone/messaging | Install telegram/discord plugin + `--channels` flag |
| **Remote Control** | Control from claude.ai/mobile | `claude remote-control` or `/rc` |
| **Scheduled Tasks** | Autonomous cloud cron agents | `/schedule` |
| **Computer Use** | Desktop/browser GUI automation | Available in Desktop/Cowork (Pro/Max) |
| **Sandbox** | Isolate bash from filesystem/network | `"sandbox": { "enabled": true }` |
| **Flicker-free rendering** | Smoother terminal UI | `CLAUDE_CODE_NO_FLICKER=1` |

### PLUGINS - Missing from your setup

| Plugin | Why you want it |
|--------|----------------|
| `hookify` | Create hooks interactively |
| `skill-creator` | Build skills faster |
| `commit-commands` | Better git commit workflow |
| `feature-dev` | Guided feature development |
| `pr-review-toolkit` | Comprehensive PR review |
| `telegram` | Channel for mobile control |
| `ralph-loop` | Interactive AI loops |
| `typescript-lsp` | LSP for TypeScript projects |
| `pyright-lsp` | LSP for Python projects |

### HOOKS - Missing from your setup

Priority hooks to add:

| Hook | Use Case |
|------|----------|
| `SessionStart` | Load context, set env vars at session start |
| `Stop` | Force continuation when work incomplete |
| `SubagentStart` | Inject security/context into all subagents |
| `PermissionDenied` | Retry logic for auto mode |
| `FileChanged` | React to .env/.envrc changes |
| `SessionEnd` | Cleanup, final logging |

### ENVIRONMENT VARIABLES - Not in your setup

| Variable | Value | Purpose |
|----------|-------|---------|
| `CLAUDE_CODE_NO_FLICKER` | `1` | Flicker-free rendering |
| `CLAUDE_CODE_BASH_MAINTAIN_PROJECT_WORKING_DIR` | `1` | Keep CWD stable |
| `CLAUDE_CODE_NEW_INIT` | `1` | Interactive project setup |
| `CLAUDE_CODE_EFFORT_LEVEL` | `high` | Persist effort via env |
| `CLAUDE_CODE_MAX_TOOL_USE_CONCURRENCY` | `15` | More parallel tools |

---

## Sources

- [Claude Code Settings](https://code.claude.com/docs/en/settings)
- [Environment Variables](https://code.claude.com/docs/en/env-vars)
- [Hooks Reference](https://code.claude.com/docs/en/hooks)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Built-in Commands](https://code.claude.com/docs/en/commands)
- [Skills](https://code.claude.com/docs/en/skills) (bundled skills table)
- [Permission Modes](https://code.claude.com/docs/en/permission-modes)
- [Model Configuration](https://code.claude.com/docs/en/model-config)
- [Agent Teams](https://code.claude.com/docs/en/agent-teams)
- [Scheduled Tasks](https://code.claude.com/docs/en/scheduled-tasks)
- [Remote Control](https://code.claude.com/docs/en/remote-control)
- [Ultraplan](https://code.claude.com/docs/en/ultraplan)
- [Fast Mode](https://code.claude.com/docs/en/fast-mode)
- [Channels](https://code.claude.com/docs/en/channels)
- [Voice Dictation](https://code.claude.com/docs/en/voice-dictation)
- [Worktrees](https://code.claude.com/docs/en/common-workflows)
- [Sandboxing](https://code.claude.com/docs/en/sandboxing)
- [Keybindings](https://code.claude.com/docs/en/keybindings)
- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)
- [Plugins Marketplace](https://github.com/anthropics/claude-plugins-official)
- [Changelog](https://code.claude.com/docs/en/changelog)
- [500+ Environment Variables](https://www.turboai.dev/blog/claude-code-environment-variables-complete-list)
- [Claude Code Hooks Guide](https://claudefa.st/blog/tools/hooks/hooks-guide)
- [AutoDream Feature](https://www.geeky-gadgets.com/claude-autodream-memory-files/)
- [Auto Mode Announcement](https://www.anthropic.com/engineering/claude-code-auto-mode)
- [Computer Use](https://claude.com/blog/dispatch-and-computer-use)
