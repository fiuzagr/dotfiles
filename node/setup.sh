#!/usr/bin/env sh

mkdir -p "$HOME/.nvm"

brew install nvm

. "$DOTFILES_PATH/node/env"
to_dotfilesrc '. "$DOTFILES_PATH/node/env"'

nvm install --lts

