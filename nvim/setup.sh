#!/usr/bin/env sh

brew_install nvim

create_symlink "$DOTFILES_PATH/nvim/lazyvim/init.lua" "$HOME/.config/nvim/init.lua"
create_symlink "$DOTFILES_PATH/nvim/lazyvim/lua" "$HOME/.config/nvim/lua"
