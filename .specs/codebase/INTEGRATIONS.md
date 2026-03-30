# External Integrations

**Analyzed:** 2025-01-28

## Package Managers & Registries

### Homebrew

**Service:** https://brew.sh

**Purpose:** Primary cross-platform package manager for both macOS and Linux

**Implementation:** `homebrew/setup.sh` and `homebrew/env`

**Configuration:**

```sh
# Auto-detects installation location
get_brew_prefix()  # Returns /opt/homebrew, /usr/local, or /home/linuxbrew/.linuxbrew

BREW_PREFIX=$(get_brew_prefix)
eval "$("$BREW_PREFIX"/bin/brew shellenv)"
```

**Authentication:** None (public packages)

**Key packages installed via brew:**

- All primary development tools
- nvim, git, gh, tmux, ghostty
- Starship, atuin, carapace, fzf, ripgrep, bat, eza
- Docker Desktop
- nvm, deno, bun
- Node.js, rustup

**Usage:**

```sh
brew install <package>
brew install --cask <app>
```

### APT (Debian/Ubuntu)

**Service:** Debian/Ubuntu package repositories

**Purpose:** Native package manager for Linux

**Implementation:** `base/setup.sh`

**Configuration:**

```sh
sudo apt update -y
sudo apt install -y build-essential make gcc curl git wget ...
```

**Key packages:**

- Build tools: build-essential, make, gcc, cmake, pkg-config, perl
- System utilities: curl, file, git, unzip, wget, xsel, xclip
- Libraries: libfreetype6-dev, libfontconfig1-dev, libxcb-xfixes0-dev, libxkbcommon-dev

## Programming Language Package Managers

### NPM/Node.js

**Primary:** npm (included with Node.js)

**Alternative:** Bun (faster, included in setup)

**Alternative:** Deno (modern JavaScript runtime)

**Implementation:** `node/setup.sh`

**Setup:**

```sh
brew install nvm         # Node Version Manager
nvm install --lts        # Install latest LTS
brew install deno        # Deno runtime
brew install oven-sh/bun/bun  # Bun runtime
```

**Configuration:** `node/env`

```sh
mkdir -p "$HOME/.nvm"
export NVM_DIR="$HOME/.nvm"
```

**Usage for opencode:**

```sh
npx --yes skills add <skill-url>
npx --yes @tech-leads-club/agent-skills install
```

### Cargo (Rust)

**Service:** https://crates.io

**Purpose:** Rust package manager

**Implementation:** `rustup/setup.sh`

**Setup:**

```sh
brew install rustup
```

**Configuration:** Automatic via rustup

### UV (Python)

**Service:** https://astral.sh/uv

**Purpose:** Fast Python package manager

**Implementation:** `uv/setup.sh`

**Setup:**

```sh
brew install uv
```

**Configuration:** `uv/env`

## Git Integration

### GitHub CLI (gh)

**Service:** https://cli.github.com

**Purpose:** GitHub interactions from terminal

**Implementation:** `git/setup.sh`

**Setup:**

```sh
brew install git
brew install gh
```

**Configuration:**

- User name and email (interactive prompt)
- Global gitconfig at ~/.gitconfig
- Includes dotfiles git config

### Git Configuration

**Implementation:** `git/setup.sh`

**Files:**

- `git/gitconfig` - Global git aliases and settings
- `git/gitignore` - Global ignore patterns
- `git/git_template/` - Hooks for all repos

**Config Includes:**

```sh
git config --global include.path "$DOTFILES_PATH/git/gitconfig"
git config --global core.excludesfile "$DOTFILES_PATH/git/gitignore"
git config --global init.templatedir "$DOTFILES_PATH/git/git_template"
```

**Key Aliases:**

- `st` - status
- `co` - checkout
- `br` - branch
- `cm` - commit
- `lg` - log graph
- `remove-merged` - Delete merged branches
- `remove-gone` - Delete branches with gone upstream

**GPG Signing:**

```ini
[commit]
  gpgsign = true
[tag]
  gpgsign = true
```

## OpenCode AI Integration

### OpenCode Service

**Service:** https://opencode.ai

**Purpose:** AI agent for development tasks

**Implementation:** `opencode/setup.sh`

**Setup:**

```sh
brew install anomalyco/tap/opencode
# OR
brew install oven-sh/bun/bun
```

**Configuration:** `opencode/config/`

```sh
create_symlink "$DOTFILES_PATH/opencode/config" "$HOME/.config/opencode"
```

**Settings:**

```sh
export DISABLE_TELEMETRY=1
```

### AI Agent Skills

**Skills installed via opencode:**

1. **agent-browser** - Browser automation
2. **building-native-ui** - Expo Router UI patterns
3. **expo-api-routes** - Expo backend routing
4. **tlc-spec-driven** - Tech Lead's Club workflow (THIS PROJECT)
5. **playwright-skill** - Playwright test automation
6. **figma** - Figma design integration
7. **figma-implement-design** - Code generation from Figma
8. **skill-creator** - Create custom skills
9. **subagent-creator** - Create specialized agents
10. **technical-design-doc-creator** - TDD generation
11. **coding-guidelines** - Code quality guidelines
12. **docs-writer** - Documentation writing
13. **best-practices** - Web best practices
14. **web-quality-audit** - Performance audits
15. **seo** - SEO optimization
16. **accessibility** - A11y audits
17. **core-web-vitals** - Core Web Vitals optimization
18. **perf-web-optimization** - Performance optimization
19. **perf-lighthouse** - Lighthouse automation
20. **security-best-practices** - Security reviews

**Installation:**

```sh
npx --yes skills add <url> --agent opencode --skill <name>
npx --yes @tech-leads-club/agent-skills install --agent opencode --skill <name>
```

**Configuration:**

All skills stored in `~/.config/opencode/skills/`

Skills support custom workflows and tools for development.

## Development Tools Integration

### Starship Prompt

**Service:** https://starship.rs

**Purpose:** Cross-shell customizable prompt

**Implementation:** `terminal-tools/setup.sh`

**Setup:**

```sh
brew install starship
create_symlink "$DOTFILES_PATH/terminal-tools/starship.toml" "$HOME/.config/starship.toml"
```

**Initialization:** `terminal-tools/env`

```sh
eval "$(starship init "$DOTFILES_SHELL")"
```

### Atuin Shell History

**Service:** https://atuin.sh

**Purpose:** Sync and search shell history across machines

**Implementation:** `terminal-tools/setup.sh`

**Setup:**

```sh
brew install atuin
```

**Initialization:** `terminal-tools/env`

```sh
eval "$(atuin init "$DOTFILES_SHELL")"
```

**Features:**

- Fuzzy search history
- Sync across devices
- Optional self-hosting

### Carapace Shell Completion

**Service:** https://github.com/rsteube/carapace

**Purpose:** Unified shell completion system

**Implementation:** `terminal-tools/setup.sh`

**Setup:**

```sh
brew install carapace
```

**Initialization:** `terminal-tools/env`

```sh
eval "$(carapace _carapace)"  # For bash
eval "$(carapace _carapace zsh)"  # For zsh
```

### Direnv

**Service:** https://direnv.net

**Purpose:** Load environment variables from .envrc files

**Implementation:** `terminal-tools/setup.sh`

**Setup:**

```sh
brew install direnv
```

**Initialization:** `terminal-tools/env`

```sh
eval "$(direnv hook "$DOTFILES_SHELL")"
```

### FZF (Fuzzy Finder)

**Service:** https://github.com/junegunn/fzf

**Purpose:** Interactive fuzzy search utility

**Implementation:** `terminal-tools/setup.sh`

**Setup:**

```sh
brew install fzf
```

**Initialization:** `terminal-tools/env`

```sh
eval "$(fzf --bash)"   # For bash
eval "$(fzf --zsh)"    # For zsh
```

### Zoxide (Smart cd)

**Service:** https://github.com/ajeetdsouv/zoxide

**Purpose:** Fast directory navigation using frecency

**Implementation:** `terminal-tools/setup.sh`

**Setup:**

```sh
brew install zoxide
create_symlink "$(which zoxide)" "$HOME/.local/bin/cd"
```

**Initialization:** `terminal-tools/env`

```sh
eval "$(zoxide init "$DOTFILES_SHELL")"
```

### Additional Terminal Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| **eza** | Modern ls replacement | brew install eza |
| **bat** | Modern cat with syntax highlighting | brew install bat |
| **fd** | Modern find replacement | brew install fd |
| **ripgrep** | Modern grep (rg) | brew install ripgrep |
| **tealdeer** | tldr man pages | brew install tealdeer |
| **fastfetch** | System info | brew install fastfetch |
| **yq** | YAML/JSON processor | brew install yq |
| **bbrew** | Homebrew TUI | brew install Valkyrie00/homebrew-bbrew/bbrew |

## Editor & IDE Integration

### Neovim + LazyVim

**Service:** https://github.com/folke/lazy.nvim

**Purpose:** Modern Vim configuration framework

**Implementation:** `nvim/setup.sh`

**Setup:**

```sh
brew install nvim
create_symlink "$DOTFILES_PATH/nvim/lazyvim/lua" "$HOME/.config/nvim/lua"
```

**Configuration:** `nvim/lazyvim/lua/` contains full LazyVim setup

### Ghostty Terminal

**Service:** https://ghostty.org/

**Purpose:** Cross-platform GPU-accelerated terminal emulator (macOS + Linux)

**Implementation:** `ghostty/setup.sh`

**Setup:**

```sh
brew install --cask ghostty
create_symlink "$DOTFILES_PATH/ghostty/config" "$HOME/.config/ghostty/config"
```

## System Integration

### Docker Desktop

**Service:** https://www.docker.com/products/docker-desktop

**Purpose:** Container runtime

**Implementation:** `docker/setup.sh`

**Setup:**

```sh
brew install docker
```

### Flatpak

**Service:** https://flatpak.org

**Purpose:** Universal application packaging (Linux)

**Implementation:** `flatpak/setup.sh`

**Setup:**

```sh
brew install flatpak
```

### Android SDK

**Service:** https://developer.android.com

**Purpose:** Android development tools

**Implementation:** `android/setup.sh`

**Setup:** Installs Android SDK, emulator, build tools

**Configuration:** `android/env` sets ANDROID_HOME

## Authentication & Security

### GPG/PGP

**Service:** GNU Privacy Guard

**Purpose:** Encryption and signing

**Implementation:** `gpg/setup.sh`

**Setup:** Installs GPG via brew

### SSH

**Service:** Secure Shell

**Purpose:** Remote access and key-based authentication

**Implementation:** `ssh/setup.sh`

**Configuration:** SSH key setup and known_hosts management

## External Services (Optional)

### Quotio (macOS only)

**Service:** Menu bar quick action app

**Purpose:** Quick code snippets and text transformations

**Implementation:** `opencode/setup.sh`

**Setup:**

```sh
brew tap nguyenphutrong/tap
brew install --cask quotio
xattr -cr /Applications/Quotio.app
```

### ClipProxyAPI (Linux only)

**Service:** Clipboard proxy for remote access

**Purpose:** Clipboard access in Linux

**Implementation:** `opencode/setup.sh`

**Setup:**

```sh
brew install cliproxyapi
brew services start cliproxyapi
```

## Integration Patterns

### Environment Variable Export Pattern

**All integrations follow:**

```sh
# installation (module/setup.sh)
brew install tool

# configuration & sourcing (module/env)
eval "$(tool init "$DOTFILES_SHELL")"
export CUSTOM_VAR="value"

# registration (module/setup.sh)
to_dotfilesrc ". \"\$DOTFILES_PATH/module/env\""
```

### Configuration Symlink Pattern

```sh
# Create symlink to config
create_symlink "$DOTFILES_PATH/module/config" "$HOME/.config/app"

# Verify symlink created
ls -l ~/.config/app  # Should show -> .../dotfiles/module/config
```

## Configuration Location Summary

| Service | Config Location | Sourced From |
|---------|-----------------|--------------|
| Starship | ~/.config/starship.toml | dotfiles/terminal-tools/ |
| Neovim | ~/.config/nvim/lua | dotfiles/nvim/lazyvim/ |
| Ghostty | ~/.config/ghostty/config | dotfiles/ghostty/ |
| Git | ~/.gitconfig | dotfiles/git/gitconfig |
| OpenCode | ~/.config/opencode | dotfiles/opencode/config |
| Tmux | ~/.config/tmux | dotfiles/tmux/config |
| SSH | ~/.ssh | System default |
| Docker | ~/.docker | System default |
