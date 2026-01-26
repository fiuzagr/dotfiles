# AGENTS.md - Dotfiles Repository Guide

## Project Overview

This is a shell-based dotfiles repository for Debian and macOS systems. It uses
modular setup scripts and shell utilities for system configuration.

## Build/Test Commands

- **Full setup**: `sh setup.sh` (installs all modules)
- **Module setup**: `sh setup.sh <module1> <module2> ...` (installs specific
  modules)
- **Test script**: `sh test.sh` (basic helper function tests - validates OS/shell detection, file operations, and RC file appending)
- **Run single test function**: Modify `test.sh` directly to isolate and run specific test sections (no command-line flags supported)
- **Build/lint verification**: No dedicated lint command exists. Code quality maintained through:
  - Manual review adherence to POSIX shell standards
  - `.editorconfig` enforcement via editor integration
  - `set -ae` strict error handling in scripts
- **Type checking**: No type checker configured (pure shell scripts)
- **Available modules**: shell, base, local, fonts, ssh, gpg, rustup, flatpak, homebrew,
  git, nvim, terminal-tools, docker, node, uv, alacritty, devtoys, opencode

## Tooling Notes

- **Package managers**: Relies on system package managers (apt/homebrew) rather than JS-based tooling
- **Dependencies**: No external linting/formatting tools (ESLint, Prettier, ShellCheck)
- **Testing**: Manual shell script execution only - no automated test runners
- **CI/CD**: No CI pipeline configured in this dotfiles repository

## Code Style Guidelines

### Shell Script Standards

- **Interpreter**: Use POSIX shell (`#!/usr/bin/env sh`) exclusively - no bash/zsh specific features
- **Safety flags**: Always use `set -ae` (abort on error, auto-export variables)
- **Exit codes**: Use `exit 0` for success, `exit 1` for failures
- **Shell compatibility**: Code must work on both bash and zsh (no bashisms or zsh-specific syntax)

### Formatting & Style

- **Indentation**: 2 spaces (enforced via .editorconfig)
- **Line length**: 80 characters maximum
- **End of line**: LF only, UTF-8 encoding
- **Final newline**: Required at end of all files
- **Trailing whitespace**: Automatically trimmed
- **Braces**: Use consistent spacing: `if [ condition ]; then` (space after `[` and before `]`)

### Naming Conventions

- **Functions**: Use lowercase with underscores: `get_os()`, `to_file()`, `create_symlink()`
- **Variables**: Function-scoped variables prefixed with function name abbreviation (e.g., `tf_file` in `to_file()`)
- **Constants**: Use UPPERCASE for exported variables (`DOTFILES_PATH`, `DOTFILES_OS`)
- **Files**: Lowercase with hyphens: `setup.sh`, `helpers.sh`, not `Setup.sh` or `helpers_script.sh`

### Error Handling & Logging

- **Error output**: Use `>&2` for all error messages (redirects to stderr)
- **Logging**: Use `log` helper function for user-facing messages in setup scripts
- **Process safety**: Check file/directory existence before operations
- **Backup strategy**: Functions like `create_symlink()` automatically backup existing files

### Comments & Documentation

- **Function documentation**: Include parameter descriptions and usage examples above each function
- **Inline comments**: Explain complex logic or cross-platform differences
- **Usage patterns**: Show both simple and advanced usage examples
- **Parameter validation**: Document required vs optional parameters clearly

### Code Organization

- **Function order**: Place helper functions before main logic
- **Modular design**: One module per tool/feature, self-contained setup scripts
- **Error propagation**: Setup scripts exit early on any module failure
- **Resource management**: Clean up temporary files and restore environment variables

### Cross-Platform Patterns

- **OS detection**: Use `get_os()` returning "darwin"/"linux" for platform-specific logic
- **Shell detection**: Use `get_shell()` returning "zsh"/"bash" for shell-specific configuration
- **Conditional execution**: Use `is_macos()` and `is_linux()` for platform guards
- **Clipboard**: Platform-specific handling (pbcopy on macOS, xclip on Linux)

## File Structure

### Root Level

- `setup.sh`: Main orchestration script handling module execution, logging, and environment setup
- `helpers.sh`: Core utility functions for OS/shell detection, file manipulation, and cross-platform operations
- `test.sh`: Basic functional tests for helper functions and setup verification
- `shml`: Terminal markup framework for colors, icons, progress bars, and UI elements
- `AGENTS.md`: This guide for agents, build commands, and code style guidelines
- `README.md`: User documentation with installation and module descriptions
- `.editorconfig`: Code formatting rules enforced across all editors
- `.gitignore`: Git ignore patterns for build artifacts, logs, and IDE files

### Module Organization

- Each module has its own directory with a `setup.sh` script
- Configuration files use appropriate extensions (.toml for configurations, .gitconfig for git, etc.)
- Platform-specific logic embedded in setup scripts with OS/shell detection
- Self-contained modules that can be installed independently

### Special Directories

- `local/`: Custom user configurations and local binaries
- `opencode/config/`: OpenCode agent configurations and Oh My OpenCode setup
- `.sisyphus/`: Task management and work planning artifacts
- `nvim/lazyvim/`: Neovim LazyVim distribution with Lua configurations

## External Rules & Agent Instructions

### Editor & IDE Rules

- **Cursor rules**: No .cursorrules or .cursor/rules/ directory found
- **Copilot instructions**: No .github/copilot-instructions.md found

### Agent-Specific Guidelines

- **Code generation**: Maintain POSIX shell compatibility - avoid bash/zsh extensions
- **File modifications**: Respect existing function patterns and naming conventions
- **Error handling**: Use `>&2` for errors, `exit 1` for failures
- **Testing**: Update test.sh when adding new helper functions
- **Documentation**: Keep parameter documentation and usage examples current

## Helper Functions Reference

### OS Detection

- `get_os()`: Returns "darwin" on macOS, "linux" on Linux, "unknown" otherwise
- `is_macos()`: Returns 0 (success) on macOS, 1 otherwise
- `is_linux()`: Returns 0 (success) on Linux, 1 otherwise

### Shell Detection & Configuration

- `get_shell()`: Returns "zsh", "bash", or "bash" (fallback)
- `to_zshrc()`: Append line to ~/.zshrc if it doesn't exist (with optional regex test)
- `to_bashrc()`: Append line to ~/.bashrc if it doesn't exist (with optional regex test)
- `to_shell_rc()`: Dispatcher that calls appropriate RC function based on detected shell

### File Operations

- `to_file()`: Append line to file if regex test doesn't match (core implementation)
- `to_dotfilesrc()`: Append line to ~/.dotfilesrc if it doesn't exist
- `create_symlink()`: Create symbolic link with automatic backup of existing files
- `link_tree()`: Create directory tree and symlink all files from source to destination

### Utilities

- `copy_to_clipboard()`: Cross-platform clipboard handling (pbcopy on macOS, xclip on Linux)
- `log()`: User-facing logging that outputs to both console and log file

### Function Usage Patterns

```bash
# Simple append
to_zshrc 'export PATH="$HOME/bin:$PATH"'

# Conditional append (only if pattern doesn't exist)
to_zshrc '\\.my_script' 'source $HOME/.my_script'

# Cross-platform dispatch
to_shell_rc 'export EDITOR=vim'

# File linking with backup
create_symlink "$DOTFILES_PATH/config" "$HOME/.config/myapp"

# Directory tree linking
link_tree "$DOTFILES_PATH/fonts" "$HOME/.fonts"
```

## macOS-Specific Notes

- **Homebrew paths**: `/opt/homebrew` (Apple Silicon) or `/usr/local` (Intel)
- **Font directory**: `~/Library/Fonts`
- **Clipboard**: `pbcopy` instead of `xclip`
- **Package manager**: `brew` instead of `apt`
