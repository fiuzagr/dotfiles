#!/usr/bin/env sh

if ! grep -q ".cargo/env" ~/.bashrc; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  . "$HOME/.cargo/env"
fi

rustup update stable
rustup default stable
