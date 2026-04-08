# Bash & WSL Learnings

## The Problem: Windows vs WSL Paths

When running commands from Windows (PowerShell/Git Bash) that target WSL, paths get mangled:

```bash
# This FAILS from Git Bash - path gets converted
wsl cat ~/.gemini/settings.json
# Error: cat: 'C:/Users/yourname/.gemini/settings.json': No such file or directory

# This ALSO FAILS - Git Bash mangles /home
wsl cat /home/yourname/.gemini/settings.json
# Error: cat: 'C:/Program Files/Git/home/yourname/...'
```

## Solution: Use PowerShell for WSL Commands

```powershell
# This WORKS - PowerShell doesn't mangle paths
powershell.exe -Command "wsl cat /home/yourname/.gemini/settings.json"
```

## Writing Files to WSL from Windows

```powershell
# Use tee to write content
powershell.exe -Command "'content here' | wsl tee /home/yourname/file.txt"

# Or use heredoc via sh -c (escaping is tricky)
powershell.exe -Command "wsl sh -c 'cat > /path/file << EOF
content
EOF'"
```

## Path Mappings

| Windows Path | WSL Path |
|--------------|----------|
| `C:\Users\yourname` | `/mnt/c/Users/yourname` |
| `~` (in Git Bash) | `C:\Users\yourname` |
| `~` (in WSL) | `/home/yourname` |
| `$HOME` (Git Bash) | `C:\Users\yourname` |
| `$HOME` (WSL) | `/home/yourname` |

## Accessing WSL Filesystem from Windows

```
\\wsl$\Ubuntu\home\yourname\
\\wsl.localhost\Ubuntu\home\yourname\
```

Note: These paths may not work in all contexts (Git Bash has issues).

## CLI-Specific Configurations

### Gemini CLI (runs in WSL)
Config location: `/home/yourname/.gemini/settings.json`

```json
{
  "includeDirectories": [
    "/mnt/c/Users/yourname/Desktop/AI",
    "/mnt/c/Users/yourname/.claude"
  ]
}
```

### Codex CLI (runs in WSL)
- Best experience in WSL, not native Windows
- Access Windows files via `/mnt/c/...`

### Claude Code (runs in Windows)
- Config: `C:\Users\yourname\.claude\`
- Uses Windows paths: `$HOME/Desktop/AI`

## Running Commands Across Environments

### From Windows PowerShell to WSL
```powershell
wsl ls /mnt/c/Users/yourname/Desktop/AI
wsl -e sh -c "command here"
```

### From Git Bash to WSL (avoid path issues)
```bash
# Don't use ~ or paths that Git Bash will mangle
# Use powershell.exe as intermediary instead
powershell.exe -Command "wsl your-command"
```

## Common Gotchas

1. **Git Bash mangles Unix paths** - `/home` becomes `C:/Program Files/Git/home`
2. **WSL ~ vs Windows ~** - They point to different directories
3. **HEREDOC escaping** - Quotes get stripped when passing through multiple shells
4. **wsl.exe path interpretation** - Sometimes interprets ~ as Windows path

## Best Practice

For multi-CLI setups where some CLIs run in WSL and some in Windows:
- Store files on Windows filesystem (`C:\Users\...\Desktop\AI`)
- WSL CLIs access via `/mnt/c/Users/.../Desktop/AI`
- Windows CLIs access via `C:\Users\...\Desktop\AI` or `~/Desktop/AI`
- Same physical files, different path formats
