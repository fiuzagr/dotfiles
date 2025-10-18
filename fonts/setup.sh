#!/usr/bin/env sh

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip -O /tmp/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip

unzip -o /tmp/FiraCode.zip -d "$HOME/.local/share/fonts/FiraCode/"
unzip -o /tmp/JetBrainsMono.zip -d "$HOME/.local/share/fonts/JetBrainsMono/"

fc-cache -fv
