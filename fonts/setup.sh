#!/usr/bin/env sh

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip -O /tmp/FiraCode.zip

unzip -o /tmp/FiraCode.zip -d "$HOME/.local/share/fonts/FiraCode/"

fc-cache -fv
