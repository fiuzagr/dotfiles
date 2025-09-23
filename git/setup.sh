#!/usr/bin/env sh

brew install git
brew install gh

touch ~/.gitconfig

if ! grep -q "$DOTFILES_PATH" ~/.gitconfig 2>/dev/null; then
  echo "[include]" >> ~/.gitconfig
  echo "  path = $DOTFILES_PATH/git/gitconfig" >> ~/.gitconfig
  echo "[core]" >> ~/.gitconfig
  echo "  excludesfile = $DOTFILES_PATH/git/gitignore" >> ~/.gitconfig
  echo "[init]" >> ~/.gitconfig
  echo "  templatedir = $DOTFILES_PATH/git/git_template" >> ~/.gitconfig
fi

if ! git config --global user.name > /dev/null 2>&1 || ! git config --global user.email > /dev/null 2>&1; then
  echo >&3
  echo "Enter your name for GIT:" >&3
  read -r NAME
  echo "Enter your email for GIT:" >&3
  read -r EMAIL
  echo >&3

  git config --global user.name "$NAME"
  git config --global user.email "$EMAIL"
fi
