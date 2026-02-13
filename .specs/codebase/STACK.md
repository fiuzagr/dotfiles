# Tech Stack

**Analyzed:** 2025-01-28

## Core

- **Language:** POSIX Shell (sh)
- **Shell Support:** bash, zsh (both compatible)
- **Package Manager (Primary):** Homebrew
- **Package Manager (Secondary):** apt (Debian/Ubuntu)

## Shell Configuration

- **Terminal Multiplexer:** tmux
- **Terminal Emulator:** Alacritty
- **Prompt:** Starship
- **Shell History:** Atuin
- **Shell Completion:** Carapace
- **Directory Jumping:** zoxide
- **Environment Loader:** direnv

## Development Tools

- **Editor:** Neovim (with LazyVim)
- **Version Control:** Git + GitHub CLI (gh)
- **Code Completion:** Carapace
- **Fuzzy Finder:** fzf

## Programming Language Runtimes

- **Node.js:** nvm (Node Version Manager)
- **JavaScript Runtime:** Deno
- **JavaScript Runtime:** Bun
- **Python:** uv (Python package manager)
- **Rust:** rustup (Rust toolchain)

## Terminal Tools (CLI Replacements)

| Traditional | Modern Replacement | Tool |
|-------------|-------------------|------|
| `ls` | `eza` | Symlinked to ~/.local/bin/ls |
| `cat` | `bat` | Symlinked to ~/.local/bin/cat |
| `find` | `fd` | Native |
| `grep` | `ripgrep (rg)` | Native |
| `cd` | `zoxide (z)` | Symlinked to ~/.local/bin/cd |
| `tldr` | `tealdeer` | Native |
| `uname/sysinfo` | `fastfetch` | Native |

## Containerization & Virtualization

- **Container Runtime:** Docker Desktop
- **Container Build:** Buildx (included with Docker)

## API & Development

- **OpenCode AI Integration:** opencode CLI
- **Package/Skills Manager:** bun, npx

## External Services

- **Code Metrics:** GitHub (for version control)
- **Shell Recording:** Atuin (self-hosted option)
- **Git Templates:** Custom hooks in git_template/

## Development Platform (Optional Modules)

- **Android Development:** Android SDK, emulator
- **Linux Packages:** Flatpak
- **GUI Tools:** DevToys
- **Markup Language:** YAML/JSON/XML processing (yq)

## Testing & Quality

| Type | Status | Details |
|------|--------|---------|
| Unit Testing | Basic | Manual test.sh script |
| Integration Testing | Planned | Need proper framework |
| E2E Testing | Not implemented | - |
| Coverage | None | No coverage tooling |

## Build System

- **Task Runner:** None (direct sh scripts)
- **Make:** Standard make (used in some builds)
- **Build Tools:** cmake, pkg-config

## Continuous Integration

- **Status:** Not configured
- **Planned:** GitHub Actions workflow for setup validation

## System Dependencies (Base)

### macOS

- **Build Tools:** Xcode Command Line Tools
- **Package Manager:** Homebrew (installed automatically)

### Linux (Debian-based)

- **Build Tools:** build-essential, make, gcc, cmake, pkg-config
- **Libraries:** libfreetype6-dev, libfontconfig1-dev, libxcb-xfixes0-dev, libxkbcommon-dev
- **Utilities:** perl, file, git, unzip, wget, xsel, xclip, python3, stow

## Architecture-Specific Notes

- **macOS:** Auto-detects Apple Silicon (/opt/homebrew) vs Intel (/usr/local)
- **Linux:** Assumes Debian/Ubuntu; uses apt for native packages, linuxbrew for cross-platform tools
