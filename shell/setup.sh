#!/usr/bin/env sh

shell_type=$(get_shell)

to_dotfilesrc ". \"\$DOTFILES_PATH/shell/common/env\""
to_dotfilesrc ". \"\$DOTFILES_PATH/shell/$shell_type/env\""
