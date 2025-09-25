#!/usr/bin/env sh

NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

to_bashrc '. "$DOTFILES_PATH/homebrew/env"'
