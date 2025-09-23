#!/usr/bin/env sh

echo 'Starship prompt' >&3
brew install starship
ln -sf "$DOTFILES_PATH/terminal-tools/starship.toml" "$HOME/.config/starship.toml"

echo 'Atuin shell history' >&3
brew install atuin

echo 'Carapace shell completer' >&3
brew install carapace

echo 'Direnv to load env variables from .envrc files' >&3
brew install direnv

echo 'eza as a ls alternative' >&3
brew install eza
ln -sf "$(which eza)" ~/.local/bin/ls

echo 'fd as a find alternative' >&3
brew install fd

echo 'ripgrep as a grep alternative' >&3
brew install ripgrep

echo 'bat as a cat alternative' >&3
brew install bat
ln -sf "$(which bat)" ~/.local/bin/cat

echo 'fzf a fuzzy finder' >&3
brew install fzf

echo 'tealdeer as a fast tldr alternative' >&3
brew install tealdeer

# disabled because has an error in stty
# see https://github.com/uutils/coreutils/issues/8608
#echo 'uutils as a coreutils alternative' >&3
#brew install uutils-coreutils

echo 'zoxide as a cd alternative' >&3
brew install zoxide
ln -sf "$(which zoxide)" ~/.local/bin/cd

echo 'yq to process yaml, json, xml, csv' >&3
brew install yq

echo 'fastfetch to show system information' >&3
brew install fastfetch

echo 'bbrew a TUI for Brew' >&3
brew install Valkyrie00/homebrew-bbrew/bbrew

ln -sf "$DOTFILES_PATH/terminal-tools/env" "$HOME/.bash_dotfiles"

to_bashrc '. "$HOME/.bash_dotfiles"'
