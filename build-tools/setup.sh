#!/usr/bin/env sh

# Install development tools and libraries via Homebrew
# This module runs after homebrew is installed, providing essential build tools for other modules

# Core development tools (cross-platform)
brew install cmake pkg-config python3 stow unzip wget

# Platform-specific tools
if is_linux; then
  # Clipboard tools for Linux
  brew install xsel xclip

  # X11 and graphics libraries for GUI development
  brew install freetype fontconfig libxcb libxkbcommon
elif is_macos; then
  # macOS has native clipboard support, skip xsel/xclip
  # Homebrew handles graphics dependencies automatically on macOS
  :
fi