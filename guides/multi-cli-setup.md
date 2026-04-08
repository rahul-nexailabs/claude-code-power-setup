# Multi-CLI Setup Guide

## Architecture Decision: Hybrid Setup

```
┌─────────────────────────────────────────────────────────────┐
│                    WINDOWS (PowerShell)                      │
│                                                              │
│   Claude Code ◄── Chrome Extension (MCP)                    │
│       │              │                                       │
│       │              └── Browser automation                  │
│       │                  Tab control                         │
│       │                  Screenshot capture                  │
│       ▼                                                      │
│   C:\Users\yourname\Desktop\AI\  ◄─── Shared Files             │
│                                                              │
└──────────────────────┬──────────────────────────────────────┘
                       │ Same files via /mnt/c/
┌──────────────────────▼──────────────────────────────────────┐
│                         WSL (Ubuntu)                         │
│                                                              │
│   Codex CLI ────► /mnt/c/Users/yourname/Desktop/AI/            │
│   Gemini CLI ───► /mnt/c/Users/yourname/Desktop/AI/            │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Why Claude Code MUST Run in Windows/PowerShell

### 1. Chrome Extension Dependency
Claude Code's `claude-in-chrome` MCP extension enables:
- Browser automation (clicking, typing, screenshots)
- Tab management
- Reading page content
- GIF recording of browser sessions

**This extension connects to the Windows Chrome browser via native messaging.**

If Claude Code runs in WSL:
- It cannot communicate with Windows Chrome
- The MCP bridge fails to connect
- All browser automation tools break

### 2. Native Messaging Protocol
Chrome extensions use native messaging to communicate with external applications.
The extension's manifest points to a Windows executable path.
WSL processes cannot receive these native messages.

### 3. Display Server Issues
Even if the extension could connect, WSL has no direct access to the Windows display.
Taking screenshots or interacting with browser UI requires Windows-level access.

## CLI Placement Summary

| CLI | Environment | Why |
|-----|-------------|-----|
| **Claude Code** | Windows (PowerShell) | Chrome extension requires Windows native messaging |
| **Codex** | WSL | Best sandboxing support, Unix tools |
| **Gemini** | WSL | Designed for Unix, 1M token context for research |

## File Access Strategy

All CLIs access the SAME physical files on Windows filesystem:

| CLI | Path Used | Physical Location |
|-----|-----------|-------------------|
| Claude Code | `C:\Users\yourname\Desktop\AI` | Windows NTFS |
| Claude Code | `~/Desktop/AI` | Windows NTFS |
| Codex | `/mnt/c/Users/yourname/Desktop/AI` | Windows NTFS (via WSL mount) |
| Gemini | `/mnt/c/Users/yourname/Desktop/AI` | Windows NTFS (via WSL mount) |

**No file duplication required.**

## Configuration Files

### Claude Code (Windows)
```
C:\Users\yourname\.claude\
├── agents\        # Agent definitions
├── commands\      # Slash commands
├── settings.json  # Global settings
└── CLAUDE.md      # Global instructions
```

### Gemini (WSL)
```
/home/yourname/.gemini/settings.json
```
```json
{
  "includeDirectories": [
    "/mnt/c/Users/yourname/Desktop/AI",
    "/mnt/c/Users/yourname/.claude",
    "/mnt/c/Users/yourname/Desktop/NexAI Labs/CEO"
  ]
}
```

### Codex (WSL)
Launch from Windows file directory:
```bash
cd /mnt/c/Users/yourname/Desktop/AI && codex
```

## Launch Commands

### Terminal 1: CEO (Claude Code in PowerShell)
```powershell
claude --resume ceo --add-dir ~/Desktop/AI/bus
```

### Terminal 2: Codex (WSL)
```bash
cd /mnt/c/Users/yourname/Desktop/AI && codex
```

### Terminal 3: Gemini (WSL)
```bash
gemini
# Already configured via settings.json to access Windows files
```

## Task Queue Flow

```
1. CEO (Claude) creates task:
   → C:\Users\yourname\Desktop\AI\bus\tasks\dev\queued\task.md

2. Codex picks up task:
   → Reads /mnt/c/Users/yourname/Desktop/AI/bus/tasks/dev/queued/task.md
   → Moves to doing/
   → Executes
   → Writes report

3. CEO synthesizes:
   → Reads reports from all agents
   → Updates BRAIN.md
```

## Troubleshooting

### "Chrome extension not responding"
- Ensure Claude Code is running in Windows PowerShell, not WSL
- Check Chrome extension is installed and enabled
- Verify native messaging host is registered

### "Gemini can't read files"
- Check `~/.gemini/settings.json` has correct includeDirectories
- Paths must use `/mnt/c/` format, not Windows paths

### "Codex can't find workspace"
- Launch from the correct directory: `cd /mnt/c/... && codex`
- Don't use Windows paths inside WSL

### "Path not found" errors
- Windows: Use `C:\` or `~/` paths
- WSL: Use `/mnt/c/` paths
- Never mix path formats within a single environment
