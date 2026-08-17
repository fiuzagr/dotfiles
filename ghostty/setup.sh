#!/usr/bin/env sh

if is_headless; then
  log 'No GUI detected. Skipping ghostty...'
  return 0
fi

brew_install --cask ghostty

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
create_symlink "$DOTFILES_PATH/ghostty/config" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
