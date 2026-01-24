#!/usr/bin/env sh

if is_macos; then
  FONTS_DIR="$HOME/Library/Fonts"
else
  FONTS_DIR="$HOME/.local/share/fonts"
fi

mkdir -p "$FONTS_DIR"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip -O /tmp/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip

unzip -o /tmp/FiraCode.zip -d "$FONTS_DIR/FiraCode/"
unzip -o /tmp/JetBrainsMono.zip -d "$FONTS_DIR/JetBrainsMono/"

if is_linux; then
  fc-cache -fv
fi
