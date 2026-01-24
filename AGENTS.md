# AGENTS.md - Dotfiles Repository Guide

## Project Overview

This is a shell-based dotfiles repository for GNOME Debian systems. It uses
modular setup scripts and shell utilities for system configuration.

## Build/Test Commands

- **Full setup**: `sh setup.sh` (installs all modules)
- **Module setup**: `sh setup.sh <module1> <module2> ...` (installs specific
  modules)
- **Test script**: `sh test.sh` (basic helper function tests)
- **Available modules**: base, local, fonts, ssh, gpg, cargo, flatpak, homebrew,
  git, vim, terminal-tools, podman, node, uv, alacritty, devtoolbox, opencode,
  jetbrains

## Code Style Guidelines

- **Shell scripts**: Use POSIX shell (`#!/usr/bin/env sh`) with `set -ae` for
  safety
- **Indentation**: 2 spaces (defined in .editorconfig)
- **Line length**: 80 characters maximum
- **End of line**: LF, UTF-8 encoding, final newline required
- **Functions**: Prefix variables with function name (e.g., `tf_file` in
  `to_file()`)
- **Error handling**: Use `>&2` for errors and `exit 1` for failures
- **Output**: Use `log` helper function for user-facing messages in setup
  scripts
- **Comments**: Document function parameters and usage examples

## File Structure

- Each module has its own directory with a `setup.sh` script
- Helper functions are in `helpers.sh` for reusability
- Configuration files use appropriate extensions (.toml, .gitconfig, etc.)

## Helper Functions

### OS Detection
- `get_os()`: Returns "darwin" on macOS, "linux" on Linux
- `is_macos()`: Returns 0 (success) on macOS, 1 otherwise
- `is_linux()`: Returns 0 (success) on Linux, 1 otherwise

### Shell Detection
- `get_shell()`: Returns "zsh", "bash", or "bash" (fallback)
- `to_zshrc()`: Append line to ~/.zshrc (analogous to to_bashrc)
- `to_shell_rc()`: Dispatcher that calls appropriate RC function based on detected shell

## macOS-Specific Notes

- **Homebrew paths**: `/opt/homebrew` (Apple Silicon) or `/usr/local` (Intel)
- **Font directory**: `~/Library/Fonts`
- **Clipboard**: `pbcopy` instead of `xclip`
- **Package manager**: `brew` instead of `apt`
