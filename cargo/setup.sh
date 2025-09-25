#!/usr/bin/env sh

if ! command -v cargo >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  . "$HOME/.cargo/env"
fi

to_bashrc '. "$DOTFILES_PATH/cargo/env"'

rustup update stable
rustup default stable
