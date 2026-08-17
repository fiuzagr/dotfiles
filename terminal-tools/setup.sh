#!/usr/bin/env sh

log 'Starship prompt'
brew_install starship
create_symlink "$DOTFILES_PATH/terminal-tools/starship.toml" "$HOME/.config/starship.toml"

log 'Atuin shell history'
brew_install atuin

log 'Carapace shell completer'
brew_install carapace

log 'Direnv to load env variables from .envrc files'
brew_install direnv

log 'eza as a ls alternative'
brew_install eza
# create_symlink "$(which eza)" "$HOME/.local/bin/ls"

log 'fd as a find alternative'
brew_install fd

log 'ripgrep as a grep alternative'
brew_install ripgrep

log 'bat as a cat alternative'
brew_install bat
create_symlink "$(which bat)" "$HOME/.local/bin/cat"

log 'fzf a fuzzy finder'
brew_install fzf

log 'tealdeer as a fast tldr alternative'
brew_install tealdeer

# disabled because has an error in stty
# see https://github.com/uutils/coreutils/issues/8608
#log 'uutils as a coreutils alternative'
#brew install uutils-coreutils

log 'zoxide as a cd alternative'
brew_install zoxide
create_symlink "$(which zoxide)" "$HOME/.local/bin/cd"

log 'yq to process yaml, json, xml, csv'
brew_install yq

log 'fastfetch to show system information'
brew_install fastfetch

log 'bbrew a TUI for Brew'
brew_install Valkyrie00/homebrew-bbrew/bbrew

to_dotfilesrc ". \"\$DOTFILES_PATH/terminal-tools/env\""
