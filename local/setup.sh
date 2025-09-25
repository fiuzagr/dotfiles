#!/usr/bin/env sh

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/var"

link_tree "$DOTFILES_PATH/local/bin" "$HOME/.local/bin"

to_bashrc '. "$DOTFILES_PATH/local/env"'
