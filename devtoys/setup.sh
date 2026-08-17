#!/usr/bin/env sh

if is_headless; then
  log 'No GUI detected. Skipping devtoys...'
  return 0
fi

brew_install --cask devtoys
