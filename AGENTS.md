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
- **Output**: Use `>&3` for user-facing messages in setup scripts
- **Comments**: Document function parameters and usage examples

## File Structure

- Each module has its own directory with a `setup.sh` script
- Helper functions are in `helpers.sh` for reusability
- Configuration files use appropriate extensions (.toml, .gitconfig, etc.)
