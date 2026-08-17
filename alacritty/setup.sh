#!/usr/bin/env sh

if is_headless; then
  log 'No GUI detected. Skipping alacritty...'
  return 0
fi

brew install --cask alacritty

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty"
create_symlink "$DOTFILES_PATH/alacritty/alacritty.toml" "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.toml"
