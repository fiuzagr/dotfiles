#!/usr/bin/env sh

if is_headless; then
  log 'No GUI detected. Skipping ghostty...'
  return 0
fi

if is_linux; then
  install_system_packages ghostty
elif is_macos; then
  brew_install --cask ghostty
fi

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
create_symlink "$DOTFILES_PATH/ghostty/config" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
