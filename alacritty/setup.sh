#!/usr/bin/env sh

brew install --cask alacritty

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty"
create_symlink "$DOTFILES_PATH/alacritty/alacritty.toml" "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.toml"
