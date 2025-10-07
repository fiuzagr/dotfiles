#!/usr/bin/env sh

brew install git
brew install gh

touch "$HOME/.gitconfig"

if ! git config --global --get-all include.path | grep -q "$DOTFILES_PATH" 2>/dev/null; then
  git config --global include.path "$DOTFILES_PATH/git/gitconfig"
  git config --global core.excludesfile "$DOTFILES_PATH/git/gitignore"
  git config --global init.templatedir "$DOTFILES_PATH/git/git_template"
fi

if ! git config --global user.name > /dev/null 2>&1 || ! git config --global user.email > /dev/null 2>&1; then
  log
  log "Enter your name for GIT:"
  read -r NAME
  log "Enter your email for GIT:"
  read -r EMAIL
  log

  git config --global user.name "$NAME"
  git config --global user.email "$EMAIL"
fi
