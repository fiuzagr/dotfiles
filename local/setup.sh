#!/usr/bin/env sh

comando_inexistente

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/var"

link_tree "$DOTFILES_PATH/local/bin" "$HOME/.local/bin"

to_dotfilesrc '. "$DOTFILES_PATH/local/env"'
