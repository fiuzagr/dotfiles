#!/usr/bin/env sh

mkdir -p "$HOME/.nvm"

brew install nvm
brew install deno
brew install oven-sh/bun/bun

. "$DOTFILES_PATH/node/env"
to_dotfilesrc ". \"\$DOTFILES_PATH/node/env\""

nvm install --lts
