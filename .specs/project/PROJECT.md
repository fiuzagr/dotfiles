# Dotfiles

**Vision:** Cross-platform dotfiles for streamlined development environment setup
on Debian-based Linux and macOS systems.

**For:** Developers who work across macOS and Linux environments and want
consistent, reproducible configurations.

**Solves:** The tedious and error-prone process of manually configuring
development environments on new machines.

## Goals

- **Primary:** Reduce new machine setup time from hours to minutes with a single
  idempotent command
- **Secondary:** Provide a modular, extensible framework that others can fork and
  customize for their needs

## Tech Stack

**Core:**

- Shell: POSIX sh (no bash/zsh-specific features)
- Primary Package Manager: Homebrew (macOS & Linux)
- Secondary Package Manager: apt (Debian/Ubuntu)

**Key dependencies:**

- shml (terminal markup for colors and formatting)
- Starship (prompt customization)
- Atuin (shell history)
- Neovim + LazyVim (editor)
- Git + GitHub CLI

## Scope

**v1 includes:**

- 20+ modules covering shell, git, nvim, docker, terminal tools, etc.
- Cross-platform support (macOS + Debian-based Linux)
- Idempotent setup scripts (safe to run multiple times)
- Shell-agnostic configuration (bash and zsh)
- OpenCode AI agent integration with skills

**Explicitly out of scope:**

- Non-Debian Linux distributions (Fedora, Arch, etc.)
- Windows/WSL support
- GUI application configurations beyond terminal emulator
- System-level security hardening

## Constraints

- **Technical:** Must maintain POSIX shell compatibility (no bashisms)
- **Philosophy:** Prefer Homebrew over native package managers for consistency
- **Resources:** Personal project, community-maintained as open source
