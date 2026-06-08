# AGENTS.md - Agent Guide for Dotfiles

Cross-platform shell-based dotfiles for macOS & Linux. POSIX sh only. Idempotent scripts.

---

## Quick Reference

### Commands

```bash
sh setup.sh                    # Full setup
sh setup.sh <module1> <module2> # Selective setup
sh test.sh                      # Run tests
```

### Modules

**System:** base, shell, local, fonts, homebrew  
**Development:** git, nvim, node, rustup, uv, docker  
**Terminal:** terminal-tools, tmux, ghostty  
**Optional:** opencode, devtoys, flatpak, android, gpg, ssh

---

## Critical Rules

**POSIX Compliance:**
- `#!/usr/bin/env sh` only
- No bash/zsh features
- `[ ... ]` for conditionals (never `[[ ... ]]`)
- `$()` for command substitution (never backticks)
- No arrays or substring expansion

**Error Handling:**
- `set -ae` always
- Errors to stderr: `>&2`
- `exit 1` for failures, `exit 0` for success
- Check existence before operations

**Naming:**
- Functions: `lowercase_with_underscores`
- Exports: `UPPERCASE_WITH_UNDERSCORES`
- Files: `lowercase-with-hyphens`

**Style:**
- 2-space indentation
- 80-char line limit
- Quote all variables: `"$var"`
- Final newline required

**Documentation:**
- Document functions above definition
- Comment *why*, not *what*

---

## Specs Directory

Load these files as needed:

| File | Purpose |
|------|---------|
| `.specs/project/PROJECT.md` | Vision, scope, tech decisions |
| `.specs/project/STATE.md` | Progress, known issues, blockers |
| `.specs/project/ROADMAP.md` | Planned features, milestones |
| `.specs/codebase/STACK.md` | Tools, languages, versions |
| `.specs/codebase/ARCHITECTURE.md` | Module patterns, dependencies, helpers |
| `.specs/codebase/CONVENTIONS.md` | Code style, POSIX rules, patterns |
| `.specs/codebase/STRUCTURE.md` | Directory tree, file locations |
| `.specs/codebase/INTEGRATIONS.md` | External APIs, auth, configuration |
| `.specs/codebase/TESTING.md` | Test frameworks, coverage, patterns |

---

## File Locations

| File | Purpose |
|------|---------|
| `~/.dotfilesrc` | Main env exports |
| `~/.bashrc` | Bash config |
| `~/.zshrc` | Zsh config |
| `~/.gitconfig` | Git config |
| `~/.config/nvim/lua` | Neovim config |
| `~/.config/starship.toml` | Prompt config |
| `~/.local/bin/` | Custom scripts |
| `~/.dotfiles/setup.log` | Setup output |

---

## Module Dependencies

Critical order: `base → shell → local → fonts → homebrew → [others]`

---

Last Updated: 2026-06-08
