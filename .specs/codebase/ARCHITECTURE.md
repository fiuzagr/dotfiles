# Architecture

**Pattern:** Modular setup system with order-dependent module orchestration

## High-Level Structure

```
dotfiles/
├── setup.sh              # Main orchestrator (entry point)
├── helpers.sh            # Core utility functions library
├── test.sh               # Test suite
├── shml                  # Terminal markup library (submodule)
├── [module]/
│   ├── setup.sh          # Module initialization script
│   └── env               # Module environment variables (optional)
└── opencode/config/      # OpenCode AI configuration
    └── skills/           # AI agent skills
```

### Core Concepts

1. **Modular Organization:** Each tool/service has its own directory with a self-contained setup.sh
2. **Order-Dependent Execution:** Modules must run in specific order (dependencies)
3. **Idempotent Operations:** All scripts are safe to run multiple times
4. **Environment Isolation:** Each module exports its env vars independently
5. **Cross-Platform:** Conditional logic based on OS detection (macOS vs Linux)

## Identified Patterns

### 1. Module Setup Pattern

**Location:** Each `[module]/setup.sh`

**Purpose:** Configure and install a specific tool or service

**Implementation:**

```sh
#!/usr/bin/env sh

# Platform-specific conditional logic (if needed)
if is_macos; then
  brew install some-tool
elif is_linux; then
  sudo apt install some-tool
fi

# Create symlinks for configs
create_symlink "$DOTFILES_PATH/module/config" "$HOME/.config/module"

# Export environment variables
to_dotfilesrc ". \"\$DOTFILES_PATH/module/env\""
```

**Pattern Details:**
- Uses `is_macos()` / `is_linux()` for platform detection
- Uses `create_symlink()` for config management
- Uses `to_dotfilesrc()` to persist environment setup
- Errors cause immediate exit (set -e in subshell)

### 2. Environment Variable Pattern

**Location:** `[module]/env`

**Purpose:** Load module-specific environment variables

**Implementation:**

```sh
#!/usr/bin/env sh

# Export PATH additions
export PATH="$HOME/.local/bin:$PATH"

# Initialize tool-specific environments
eval "$(starship init "$DOTFILES_SHELL")"
eval "$(atuin init "$DOTFILES_SHELL")"
```

**Pattern Details:**
- Sourced from .dotfilesrc after all modules are installed
- Uses shell-agnostic approach (references $DOTFILES_SHELL variable)
- Can contain eval statements for tool initialization

### 3. Helper Function Pattern

**Location:** `helpers.sh`

**Purpose:** Shared utility functions for all modules

**Key Functions:**
- `get_os()` - Detect operating system
- `is_macos()` / `is_linux()` - OS-specific conditionals
- `get_shell()` - Detect current shell (bash/zsh)
- `get_package_manager()` - Detect system's native package manager
- `install_system_packages()` - Install packages using system's package manager
- `to_file()` - Append lines to config files idempotently
- `to_dotfilesrc()` / `to_bashrc()` / `to_zshrc()` - Shell RC mutations
- `to_shell_rc()` - Platform-agnostic RC mutation
- `create_symlink()` - Create idempotent symlinks with backups
- `link_tree()` - Create tree of symlinks from source directory

### 4. Setup Orchestration Pattern

**Location:** `setup.sh` (main script)

**Purpose:** Coordinate module execution

**Implementation:**
- Detects full setup (no args) vs selective module setup (with args)
- Loads environment variables (DOTFILES_PATH, DOTFILES_OS, DOTFILES_SHELL)
- Creates/rotates log file
- Executes modules in order within subshells (error isolation)
- Exports OS and shell detection for use in modules

## Data Flow

### First-Time Setup (Full)

```
User runs: sh setup.sh
    ↓
setup.sh validates path and initializes environment
    ↓
Creates/sources helpers.sh
    ↓
Detects OS and Shell (macOS/Linux, bash/zsh)
    ↓
Creates ~/.dotfilesrc with exports
    ↓
    For each module in order (base → homebrew → build-tools → shell → local → ... → opencode):
        └─ Source module/setup.sh
           └─ Create symlinks, install packages, configure
           └─ Append to ~/.dotfilesrc: ". $DOTFILES_PATH/module/env"
    ↓
All environment variables now available in new shell session
```

### Selective Module Setup

```
User runs: sh setup.sh node nvim
    ↓
setup.sh validates ~/.dotfilesrc exists
    ↓
Runs only "node" and "nvim" module setups
    ↓
Updates their environment exports in ~/.dotfilesrc
```

### Environment Load At Shell Startup

```
When shell starts:
    ~/.bashrc or ~/.zshrc is sourced
        ↓
    Sources ~/.dotfilesrc
        ↓
    ~/.dotfilesrc sources all module/env files
        ↓
    Starship, Atuin, Carapace, etc. initialized
        ↓
    User shell ready
```

## Module Dependency Graph

**Critical Path (must run in order):**

```
base → homebrew → build-tools → shell → [other modules]
```

**Reasoning:**
- `base`: Installs minimal system dependencies (gcc/make/curl/git via native package manager)
- `homebrew`: Must run after base; provides cross-platform package manager
- `build-tools`: Must run after homebrew; installs development tools (cmake/python/stow) via brew
- `shell`: Initializes shell configuration before other env setup
- Others: Most can run in parallel, but dependencies noted below

**Dependency Annotations:**

- `build-tools`: Depends on `homebrew` (uses brew to install development packages)
- `node`: Depends on `homebrew` (uses `brew install nvm`)
- `local`: Depends on `base` (uses ~/.local/bin created in base)
- `nvim`: Depends on `homebrew`
- `git`: Depends on `homebrew` (uses `brew install git gh`)
- `terminal-tools`: Depends on `homebrew` (installs many brew packages)
- `opencode`: Depends on `node` (uses `npx` and `bun`)

## Code Organization

**Approach:** Feature-based with optional shared utilities

**Structure:**

- **Root level:** Core orchestration and helpers
- **Module directories:** Self-contained feature implementations
- **opencode/config:** AI agent configuration (skills, settings)

**Module Boundaries:**

- **Shell configuration** (shell/): Multiple shells supported (bash, zsh)
- **Package manager setup** (homebrew, build-tools, node, rustup, uv): Tools and package managers
- **Tool configuration** (nvim, git, tmux, etc.): Per-tool
- **System setup** (base, fonts, local): System-wide configuration
- **Optional features** (devtoys, opencode, flatpak): Can be enabled/disabled

## Error Handling Strategy

**Approach:** Fail-fast with logging

- Each module runs in subshell (set -e mode)
- Module failure exits immediately, logs error
- Main setup.sh checks exit code and halts
- All output redirected to setup.log
- User sees colored error messages with log file reference

**Key Pattern (line 88-101 in setup.sh):**

```sh
set +e
(
  set -e
  . "$DOTFILES_PATH/$module/setup.sh"
)
MODULE_EXIT_CODE=$?
set -e

if [ $MODULE_EXIT_CODE -ne 0 ]; then
  log_error "Module '$module' setup failed." "$LOG_FILE"
  exit 1
fi
```

This allows graceful error capture and reporting.
