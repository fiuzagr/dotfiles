#!/usr/bin/env sh

brew install sst/tap/opencode

link_tree "$DOTFILES_PATH/opencode/bin" "$HOME/.local/bin"

create_symlink "$DOTFILES_PATH/opencode/config" "$HOME/.config/opencode"
