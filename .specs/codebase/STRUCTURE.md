# Project Structure

**Root:** `/Users/fiuzagr/workspace/fiuzagr/dotfiles` (typically `~/.dotfiles`)

## Directory Tree

```
dotfiles/
├── .git/                          # Git repository
├── .specs/                        # TLC Spec-Driven documentation (this project)
│   ├── project/
│   │   ├── PROJECT.md
│   │   ├── ROADMAP.md
│   │   └── STATE.md
│   └── codebase/
│       ├── STACK.md
│       ├── ARCHITECTURE.md
│       ├── CONVENTIONS.md
│       ├── STRUCTURE.md
│       ├── TESTING.md
│       └── INTEGRATIONS.md
├── shml/                          # Terminal markup library (submodule)
├── .gitignore
├── README.md
├── setup.sh                       # Main orchestrator script
├── helpers.sh                     # Core utility functions
├── test.sh                        # Test suite
│
├── base/                          # System dependencies setup
│   └── setup.sh
│
├── shell/                         # Shell configuration
│   ├── setup.sh
│   ├── common/
│   │   └── env
│   ├── bash/
│   │   └── env
│   └── zsh/
│       └── env
│
├── local/                         # Local bin and directory structure
│   ├── setup.sh
│   ├── env
│   └── bin/
│       └── [custom scripts]
│
├── fonts/                         # Font setup and installation
│   └── setup.sh
│
├── homebrew/                      # Homebrew installation and setup
│   ├── setup.sh
│   └── env
│
├── build-tools/                   # Development tools and libraries via Homebrew
│   └── setup.sh
│
├── node/                          # Node.js, npm, nvm setup
│   ├── setup.sh
│   └── env
│
├── rustup/                        # Rust toolchain setup
│   └── setup.sh
│
├── uv/                            # UV Python package manager setup
│   ├── setup.sh
│   └── env
│
├── git/                           # Git configuration
│   ├── setup.sh
│   ├── gitconfig
│   ├── gitignore
│   └── git_template/
│       └── [hooks]
│
├── gpg/                           # GPG/PGP setup
│   └── setup.sh
│
├── ssh/                           # SSH configuration
│   └── setup.sh
│
├── shell/                         # Shell environment
│   ├── setup.sh
│   ├── common/env
│   ├── bash/env
│   └── zsh/env
│
├── terminal-tools/                # CLI tool replacements and setup
│   ├── setup.sh
│   ├── env
│   └── starship.toml
│
├── tmux/                          # Tmux multiplexer setup
│   ├── setup.sh
│   └── config/
│       └── [tmux configs]
│
├── nvim/                          # Neovim editor setup
│   ├── setup.sh
│   └── lazyvim/
│       └── lua/
│           └── [LazyVim config]
│
├── ghostty/                       # Ghostty terminal setup
│   ├── setup.sh
│   └── config
│
├── docker/                        # Docker Desktop setup
│   └── setup.sh
│
├── flatpak/                       # Flatpak container system setup
│   └── setup.sh
│
├── android/                       # Android SDK setup
│   ├── setup.sh
│   └── env
│
├── devtoys/                       # DevToys (optional developer tools)
│   └── setup.sh
│
├── opencode/                      # OpenCode AI agent integration
│   ├── setup.sh
│   └── config/
│       ├── opencode.json
│       ├── skills/               # AI agent skills
│       │   ├── tlc-spec-driven/
│       │   ├── agent-browser/
│       │   ├── figma/
│       │   └── [other skills]/
│       └── node_modules/         # AI SDK dependencies
│
├── test-module/                   # Example/template module
│   └── setup.sh
│
└── [other modules]/               # Additional specialized modules
```

## Module Organization

### Category: System Setup

| Module | Purpose | Key Files |
|--------|---------|-----------|
| **base** | System dependencies | setup.sh (installs Xcode CLT, apt packages) |
| **homebrew** | Package manager | setup.sh, env |
| **build-tools** | Development tools via Homebrew | setup.sh |
| **fonts** | Font installation | setup.sh (sets up system fonts) |
| **local** | Local directory structure | setup.sh, env, bin/ |

### Category: Shell & Terminal

| Module | Purpose | Key Files |
|--------|---------|-----------|
| **shell** | Shell configuration | setup.sh, common/env, bash/env, zsh/env |
| **terminal-tools** | CLI tools | setup.sh, env, starship.toml |
| **tmux** | Terminal multiplexer | setup.sh, config/ |
| **ghostty** | Terminal emulator | setup.sh, config |

### Category: Development Tools

| Module | Purpose | Key Files |
|--------|---------|-----------|
| **git** | Version control | setup.sh, gitconfig, gitignore, git_template/ |
| **nvim** | Code editor | setup.sh, lazyvim/lua/ |
| **node** | JavaScript runtime | setup.sh, env |
| **rustup** | Rust toolchain | setup.sh |
| **uv** | Python package manager | setup.sh, env |
| **docker** | Containerization | setup.sh |

### Category: Optional/Specialized

| Module | Purpose | Key Files |
|--------|---------|-----------|
| **opencode** | AI agent integration | setup.sh, config/ |
| **devtoys** | Developer tools | setup.sh |
| **flatpak** | Container system | setup.sh |
| **android** | Android development | setup.sh, env |
| **gpg** | GPG/PGP encryption | setup.sh |
| **ssh** | SSH configuration | setup.sh |

## Where Things Live

### Shell Configuration

- **User RC files:** ~/.bashrc, ~/.zshrc
- **Dotfiles config:** ~/.dotfilesrc (created by setup.sh)
- **Source:** .specs/shell/ modules

### Git Configuration

- **User config:** ~/.gitconfig (created by setup.sh)
- **Global includes:** Points to $DOTFILES_PATH/git/gitconfig
- **Ignore rules:** $DOTFILES_PATH/git/gitignore
- **Templates:** $DOTFILES_PATH/git/git_template/ hooks

### Editor Configuration

- **Neovim:** ~/.config/nvim/lua → symlink to nvim/lazyvim/lua/
- **Alacritty:** ~/.config/alacritty/alacritty.toml → symlink
- **Starship:** ~/.config/starship.toml → symlink to terminal-tools/starship.toml

### Local Scripts & Binaries

- **Location:** ~/.local/bin/
- **Sourced from:** dotfiles/local/bin/
- **Created by:** link_tree() function in helpers.sh

### Environment Variables

- **Aggregation point:** ~/.dotfilesrc
- **Created by:** setup.sh
- **Sources from:** All module/env files
- **Loaded in:** ~/.bashrc and ~/.zshrc

### OpenCode Skills

- **Location:** ~/.config/opencode/skills/
- **Sourced from:** opencode/config/skills/
- **Setup by:** opencode/setup.sh module

## Special Directories

### `.specs/`

**Purpose:** TLC Spec-Driven project documentation

**Examples:**

- `project/PROJECT.md` - Project vision and scope
- `project/ROADMAP.md` - Feature roadmap
- `project/STATE.md` - Project state and decisions
- `codebase/STACK.md` - Technology stack
- `codebase/ARCHITECTURE.md` - System architecture
- `codebase/CONVENTIONS.md` - Code style guides
- `codebase/STRUCTURE.md` - Directory structure
- `codebase/TESTING.md` - Testing strategy
- `codebase/INTEGRATIONS.md` - External integrations

### `shml/`

**Purpose:** Terminal markup library (git submodule)

**Usage:** Sourced by helpers.sh for colored output (fgc, hr, etc.)

### `git_template/`

**Purpose:** Git hooks to run automatically on certain events

**Examples:**

- `pre-commit` - Runs before commit
- `post-merge` - Runs after merge

### `opencode/config/skills/`

**Purpose:** AI agent skills installed by opencode/setup.sh

**Structure:**

```
skills/
├── tlc-spec-driven/       # This project's workflow
├── agent-browser/         # Browser automation
├── figma/                 # Figma design integration
├── playground-skill/      # Experimental skill
└── [other skills]/
```

## Key Configuration Files

| File | Purpose | Created By |
|------|---------|------------|
| ~/.dotfilesrc | Main env exports | setup.sh (main) |
| ~/.bashrc | Bash shell config | to_bashrc() |
| ~/.zshrc | Zsh shell config | to_zshrc() |
| ~/.gitconfig | Git user config | git/setup.sh |
| ~/.config/nvim/lua | Neovim config | nvim/setup.sh (symlink) |
| ~/.config/starship.toml | Starship prompt | terminal-tools/setup.sh (symlink) |
| ~/.config/ghostty/config | Ghostty config | ghostty/setup.sh (symlink) |
| ~/.config/opencode/config | OpenCode config | opencode/setup.sh (symlink) |
| ~/.local/bin/ | Custom scripts | local/setup.sh (link_tree) |

## Dependency Recommendations

**Before running full setup:**

```bash
git clone https://github.com/fiuzagr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sh setup.sh
```

**Module order matters (see setup.sh line 60):**

```
base → homebrew → build-tools → shell → local → fonts → flatpak → node → rustup → uv → ssh → gpg → git → terminal-tools → tmux → nvim → ghostty → docker → android → devtoys → opencode
```

This ensures dependencies are installed before modules that need them.
