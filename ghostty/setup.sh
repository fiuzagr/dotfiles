#!/usr/bin/env sh

brew install --cask ghostty

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
create_symlink "$DOTFILES_PATH/ghostty/config" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
