#!/usr/bin/env sh

DOTFILES_PATH="$(cd -P -- "$(dirname -- "${0}")" && printf '%s\n' "$(pwd -P)")"
export DOTFILES_PATH

. "$DOTFILES_PATH/helpers.sh"

to_bashrc 'apple=banana'
to_bashrc 'banana=banana' 'export banana=banana'
