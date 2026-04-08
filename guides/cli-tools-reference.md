# AI CLI Tools Reference
> WSL Ubuntu recommended for all. Projects in ~/code/ NOT /mnt/c/

## Install Commands (WSL Ubuntu)
```bash
# Claude Code
curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Node.js (for Codex + Gemini)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# restart terminal
nvm install 22

# Codex
npm i -g @openai/codex

# Gemini
npm i -g @google/gemini-cli

# Browser support
sudo apt install wslu
echo 'export BROWSER=wslview' >> ~/.bashrc
```

## Compatibility Matrix
```
Tool        | WSL   | Win Native | Notes
------------|-------|------------|---------------------------
Claude Code | 99%   | 70%        | Scripts fail on Windows
Codex       | ~85%  | ~75%       | Auth bugs WSL, perm bugs Win
Gemini      | 95%   | 60%        | cmd.exe default on Win
```

## Known Issues
```
WSL:
- Codex auth "Reconnecting" loop: github.com/openai/codex/issues/7623
- Codex API key fails: github.com/openai/codex/issues/6620
- Codex can't run .exe: github.com/openai/codex/issues/7886
- Slow I/O on /mnt/c/ paths

Windows Native:
- Codex permission/file creation: github.com/openai/codex/issues/2549
- Codex shell chain bug (GitBash->PS->Python): github.com/openai/codex/issues/7298
- Gemini defaults cmd.exe: github.com/openai/codex/issues/2353
- Claude Code POSIX shell required error
```

## Auth Methods
```
Claude Code: OAuth browser (Anthropic account) or ANTHROPIC_API_KEY
Codex: ChatGPT account (uses Plus/Pro sub) or OPENAI_API_KEY
Gemini: Google account (free 60rpm/1000rpd) or GOOGLE_API_KEY
```

## Free Tiers
```
Claude Code: None (Pro $20/mo or API)
Codex: ChatGPT sub or API
Gemini: 60rpm, 1000rpd, 1M context, Gemini 2.5 Pro
```

## Performance Rankings (user reviews)
```
Code quality: Claude > Codex > Gemini
Autonomy: Claude (single-shot) > Codex > Gemini (needs nudging)
Free value: Gemini > Codex > Claude
Context window: Gemini 1M > Claude 200K > Codex 128K
```

## Config Files
```
Claude Code: ~/.claude/settings.json
Codex: ~/.codex/config.toml
Gemini: ~/.gemini/settings.json
```

### Codex config.toml (enable web search)
```toml
[features]
web_search_request = true
```

### Codex CLI flags
```
--search      Enable web search
--full-auto   Auto-approve most commands
codex --search --full-auto   # Combined
```

## Critical Paths
```
WSL Ubuntu home: /home/yourname/
Windows access: \\wsl$\Ubuntu\home\yourname\
Recommended project loc: ~/code/
Avoid: /mnt/c/Users/... (slow, permission issues)
```

## Troubleshooting
```
"command not found" -> check PATH, source ~/.bashrc
Browser won't open -> ensure wslu installed, BROWSER=wslview
Codex reconnecting -> try Windows PowerShell instead
Slow file ops -> move project to ~/code/
Permission denied -> don't use sudo for npm global installs
```
