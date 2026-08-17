#!/usr/bin/env sh

mkdir -p "$HOME/.nvm"

brew_install nvm
brew_install deno
brew_install oven-sh/bun/bun

. "$DOTFILES_PATH/node/env"
to_dotfilesrc ". \"\$DOTFILES_PATH/node/env\""

nvm install --lts
nvm alias default 'lts/*'
nvm use default
