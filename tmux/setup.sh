#!/usr/bin/env sh

brew install tmux

create_symlink "$DOTFILES_PATH/tmux/config/tmux.conf" "$HOME/.tmux.conf"
