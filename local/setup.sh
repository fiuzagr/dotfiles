#!/usr/bin/env sh

mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/share
mkdir -p ~/.local/var

cp -r "$DOTFILES_PATH"/local/bin/* ~/.local/bin/
export PATH="$HOME/.local/bin:$PATH" # temporarily add to path for the setup access the bin scripts
