#!/usr/bin/env sh

brew install sst/tap/opencode

create_symlink "$DOTFILES_PATH/opencode/config" "$HOME/.config/opencode"
