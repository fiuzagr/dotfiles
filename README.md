# ~/.dotfiles

Dotfiles repository for streamlined development environment setup on Debian-based Linux and macOS systems.

<!--toc:start-->

- [~/.dotfiles](#dotfiles)
  - [Vision](#vision)
  - [Quick Start](#quick-start)
  - [Tech Stack](#tech-stack)
  - [Installation](#installation)
  - [Modules](#modules)
  - [Architecture](#architecture)
  - [Integrations](#integrations)

<!--toc:end-->

## Vision

This repository provides a **cross-platform dotfiles system** that reduces new machine setup from hours to minutes. Designed for developers who work across macOS and Linux environments and want consistent, reproducible configurations.

**For:** Developers who want to reduce setup time while maintaining a modular, extensible framework

**Solves:** The tedious and error-prone process of manually configuring development environments on new machines

**Key Features:**
- ✅ Idempotent setup (safe to run multiple times)
- ✅ Cross-platform (macOS & Debian-based Linux)
- ✅ Shell-agnostic (bash & zsh compatible)
- ✅ Modular design (install only what you need)
- ✅ POSIX-compliant shell scripts (no bashisms)
- ✅ 20+ modules for development, tools, and system setup

> **NOTE:** Supports `bash` and `zsh` shells on macOS and Debian-based Linux (Ubuntu, Debian, etc.)

---

## Quick Start

### 1. Clone this repository

```shell
git clone https://github.com/fiuzagr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Run setup.sh script

```shell
sh setup.sh
```

**Full Setup** - Installs all modules:
```shell
sh setup.sh
```

**Selective Setup** - Install specific modules after full setup:
```shell
sh setup.sh node nvim docker
```

**Test your setup:**
```shell
sh test.sh
```

> **TIP:** This is an idempotent tool. You can run it multiple times without any issues.

> **WARNING:** If you cancel the setup script mid-execution, it will not revert changes and may affect your previous dotfiles configuration. Simply run `sh setup.sh` again to ensure all configurations are applied correctly.

---

## Tech Stack

### Core Technologies

| Component | Technology | Details |
|-----------|-----------|---------|
| **Language** | POSIX Shell (sh) | No bash/zsh-specific features |
| **Shell Support** | bash, zsh | Both fully compatible |
| **Primary PM** | Homebrew | Cross-platform (macOS & Linux) |
| **Secondary PM** | apt | Debian/Ubuntu native packages |

### Terminal & Prompt

| Tool | Purpose | Installation |
|------|---------|--------------|
| **Starship** | Cross-shell customizable prompt | brew install starship |
| **Atuin** | Shell history sync & search | brew install atuin |
| **Carapace** | Unified shell completion | brew install carapace |
| **Alacritty** | GPU-accelerated terminal | brew install --cask alacritty |
| **Tmux** | Terminal multiplexer | brew install tmux |

### Development Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| **Git + GitHub CLI** | Version control & GitHub integration | brew install git gh |
| **Neovim** | Modern Vim editor with LazyVim | brew install nvim |
| **Docker Desktop** | Containerization | brew install docker |
| **FZF** | Fuzzy finder utility | brew install fzf |
| **Ripgrep** | Fast grep replacement | brew install ripgrep |

### Language Runtimes

| Language | Manager | Details |
|----------|---------|---------|
| **Node.js** | nvm | Installed via brew, node/setup.sh |
| **Rust** | rustup | brew install rustup |
| **Python** | uv | Fast Python package manager |
| **Deno** | Native | brew install deno |
| **Bun** | Native | Faster npm alternative |

### CLI Replacements

Modern replacements for traditional Unix tools:

| Traditional | Modern | Tool | Installed By |
|-------------|--------|------|--------------|
| `ls` | `eza` | Modern ls replacement | terminal-tools |
| `cat` | `bat` | cat with syntax highlighting | terminal-tools |
| `find` | `fd` | Modern find replacement | terminal-tools |
| `grep` | `ripgrep` | Fast grep (rg) | terminal-tools |
| `cd` | `zoxide` | Smart directory navigation | terminal-tools |
| `tldr` | `tealdeer` | Quick man pages | terminal-tools |

### Optional Modules

| Module | Purpose |
|--------|---------|
| **OpenCode** | AI agent integration & skills |
| **DevToys** | Developer utility tools |
| **Flatpak** | Universal app packaging |
| **Android SDK** | Android development |
| **GPG** | Encryption & signing |
| **SSH** | Remote access & keys |

---

## Installation

### Prerequisites

Before running setup.sh, ensure you have:

**macOS:**
- Internet connection
- Administrator access (for sudo commands)
- Xcode Command Line Tools will be installed automatically

**Linux (Debian-based):**
- Internet connection
- `sudo` access
- `curl` or `wget` installed
- Supported distributions: Ubuntu, Debian, Linux Mint, etc.

### Installation Steps

```shell
# 1. Clone the repository
git clone https://github.com/fiuzagr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Run full setup (installs all modules)
sh setup.sh

# 3. Start a new shell session (to load configurations)
exec $SHELL
```

### Updating Setup

After initial setup, you can:

**Re-run full setup** (idempotent - safe to run multiple times):
```shell
sh ~/.dotfiles/setup.sh
```

**Run setup from anywhere** (via alias created by setup):
```shell
dotfiles
```

**Install specific modules only**:
```shell
sh ~/.dotfiles/setup.sh node nvim docker
```

---

## Modules

All modules are located in `~/.dotfiles/[module-name]/` with a `setup.sh` script.

### System Setup (Foundation)

| Module | Purpose | Install Command |
|--------|---------|-----------------|
| **base** | System dependencies, build tools, Xcode CLT | `sh setup.sh base` |
| **homebrew** | Package manager installation | `sh setup.sh homebrew` |
| **shell** | Shell environment (bash/zsh) | `sh setup.sh shell` |
| **local** | Local bin directory & custom scripts | `sh setup.sh local` |
| **fonts** | System font installation | `sh setup.sh fonts` |

### Development Tools

| Module | Purpose | Install Command |
|--------|---------|-----------------|
| **git** | Git config, aliases, hooks, GitHub CLI | `sh setup.sh git` |
| **nvim** | Neovim + LazyVim configuration | `sh setup.sh nvim` |
| **node** | Node.js, npm, nvm setup | `sh setup.sh node` |
| **rustup** | Rust toolchain | `sh setup.sh rustup` |
| **uv** | Python package manager | `sh setup.sh uv` |
| **docker** | Docker Desktop | `sh setup.sh docker` |

### Terminal & Tools

| Module | Purpose | Install Command |
|--------|---------|-----------------|
| **terminal-tools** | Starship, Atuin, Carapace, fzf, ripgrep, bat, eza, etc. | `sh setup.sh terminal-tools` |
| **tmux** | Tmux configuration | `sh setup.sh tmux` |
| **alacritty** | Alacritty terminal config | `sh setup.sh alacritty` |

### Optional/Specialized

| Module | Purpose | Install Command |
|--------|---------|-----------------|
| **opencode** | OpenCode AI agent + skills | `sh setup.sh opencode` |
| **devtoys** | Developer utility tools | `sh setup.sh devtoys` |
| **flatpak** | Flatpak container system (Linux) | `sh setup.sh flatpak` |
| **android** | Android SDK & tools | `sh setup.sh android` |
| **gpg** | GPG/PGP encryption | `sh setup.sh gpg` |
| **ssh** | SSH configuration | `sh setup.sh ssh` |

### Module Execution Order

Modules run in dependency order during full setup. Order matters because:

```
base → shell → local → fonts → homebrew → flatpak → node → rustup → 
uv → ssh → gpg → git → terminal-tools → tmux → nvim → alacritty → 
docker → android → devtoys → opencode
```

- `base` installs system dependencies
- `homebrew` provides package manager for all others
- `shell` initializes shell config before env setup
- `node` required by `opencode`
- Others mostly independent but order ensures stability

---

## Architecture

### High-Level Design

The dotfiles system uses a **modular orchestration pattern**:

```
setup.sh (main entry point)
  ├─ Loads helpers.sh (utility functions)
  ├─ Detects OS (macOS/Linux) and Shell (bash/zsh)
  ├─ For each module in dependency order:
  │   └─ Executes [module]/setup.sh
  │       ├─ Install packages (via brew/apt)
  │       ├─ Create symlinks for configs
  │       └─ Register module/env in ~/.dotfilesrc
  └─ All environment variables loaded at shell startup
```

### Idempotency

All scripts are **idempotent** - safe to run multiple times:

- Symlink creation checks if already exists
- Configuration appends check for duplicates
- Package installation checks if already installed
- No destructive operations without backups

### Environment Loading

```
User starts shell
  └─ ~/.bashrc or ~/.zshrc loaded
      └─ Sources ~/.dotfilesrc
          └─ Sources all module/env files
              └─ Starship, Atuin, Carapace, etc. initialized
                  └─ Shell ready with full configuration
```

### Error Handling

- Modules run in subshells with `set -e` (fail on any error)
- Module failure exits immediately with error message
- All output logged to `~/.dotfiles/setup.log`
- Can safely re-run setup to fix issues

---

## Integrations

This dotfiles system integrates with multiple external services and tools:

### Package Managers

- **Homebrew** (https://brew.sh) - Primary package manager for macOS and Linux
- **apt** - Debian/Ubuntu native packages
- **npm/Bun/Deno** - JavaScript package managers (via node module)
- **Cargo** - Rust packages (via rustup module)
- **uv** - Python packages (via uv module)

### Development Services

- **GitHub CLI** (gh) - GitHub integration from terminal
- **Docker** - Container runtime
- **Android SDK** - Android development tools

### Terminal & Prompt Tools

- **Starship** (https://starship.rs) - Customizable prompt
- **Atuin** (https://atuin.sh) - Shell history sync
- **Carapace** - Unified shell completion
- **FZF** - Fuzzy finder
- **Zoxide** - Smart directory navigation
- **Direnv** - Environment variable loading

### AI & Development

- **OpenCode** (https://opencode.ai) - AI agent for development
- **Agent Skills** - Custom skills for automation and development

### Editor & IDE

- **Neovim** - Modern Vim with LazyVim distribution
- **Alacritty** - GPU-accelerated terminal emulator

### Configuration Management

See `.specs/codebase/INTEGRATIONS.md` for detailed information about:
- Authentication methods
- Configuration locations
- Integration patterns
- External API usage

---

## Additional Resources

For detailed information, see the `.specs/` documentation:

- **Project Vision & Scope** → `.specs/project/PROJECT.md`
- **Roadmap** → `.specs/project/ROADMAP.md`
- **Tech Stack Details** → `.specs/codebase/STACK.md`
- **Architecture & Patterns** → `.specs/codebase/ARCHITECTURE.md`
- **Code Conventions** → `.specs/codebase/CONVENTIONS.md`
- **Directory Structure** → `.specs/codebase/STRUCTURE.md`
- **Testing** → `.specs/codebase/TESTING.md`
- **Integrations** → `.specs/codebase/INTEGRATIONS.md`

---

## Testing

Validate your setup with the test script:

```shell
sh test.sh
```

This runs basic tests for core helper functions. For comprehensive information about testing, see `.specs/codebase/TESTING.md`.

---

## Contributing

This is an open-source project. To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Follow the code conventions in `.specs/codebase/CONVENTIONS.md`
4. Test your changes: `sh test.sh`
5. Commit with clear messages
6. Push and create a pull request

See `.specs/project/ROADMAP.md` for planned features and `.specs/project/STATE.md` for current project status.

---

## License

Licensed under MIT. See LICENSE file for details.

---

> Chupinhado from <https://github.com/luanfrv0/dotfiles>
