#!/usr/bin/env sh

if is_headless; then
  log 'No GUI detected. Skipping flatpak...'
  return 0
fi

if is_macos; then
  log 'Flatpak is not available on macOS. Skipping...'
  return 0
fi

brew install flatpak

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
