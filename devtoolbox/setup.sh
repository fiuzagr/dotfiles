#!/usr/bin/env sh

if is_macos; then
  brew install --cask devtoys
else
  flatpak install -y --user flathub me.iepure.devtoolbox
fi
