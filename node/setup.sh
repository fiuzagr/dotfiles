#!/usr/bin/env sh

mkdir -p "$HOME/.nvm"

brew_install nvm
brew_install deno
brew_install oven-sh/bun/bun

to_dotfilesrc ". \"\$DOTFILES_PATH/node/env\""

run_in_bash "$DOTFILES_PATH/node/env" "nvm install --lts && nvm alias default 'lts/*' && nvm use default"
