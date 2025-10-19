#!/usr/bin/env sh

brew install nvim

create_symlink "$DOTFILES_PATH/nvim/lazyvim/lua" "$HOME/.config/nvim/lua"
