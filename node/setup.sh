#!/usr/bin/env sh

mkdir -p ~/.nvm

brew install nvm
nvm install --latest

to_bashrc ". '$DOTFILES_PATH/node/env'"


