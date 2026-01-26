#!/usr/bin/env sh

brew install --cask alacritty

if command -v update-alternatives >/dev/null 2>&1; then
  if ! update-alternatives --query x-terminal-emulator | grep -q "$(which alacritty)"; then
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(which alacritty)" 50
    sudo update-alternatives --set x-terminal-emulator "$(which alacritty)"
  fi
fi

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty"
create_symlink "$DOTFILES_PATH/alacritty/alacritty.toml" "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.toml"
