#!/usr/bin/env sh

log 'Starship prompt'
brew install starship
create_symlink "$DOTFILES_PATH/terminal-tools/starship.toml" "$HOME/.config/starship.toml"

log 'Atuin shell history'
brew install atuin

log 'Carapace shell completer'
brew install carapace

log 'Direnv to load env variables from .envrc files'
brew install direnv

log 'eza as a ls alternative'
brew install eza
create_symlink "$(which eza)" "$HOME/.local/bin/ls"

log 'fd as a find alternative'
brew install fd

log 'ripgrep as a grep alternative'
brew install ripgrep

log 'bat as a cat alternative'
brew install bat
create_symlink "$(which bat)" "$HOME/.local/bin/cat"

log 'fzf a fuzzy finder'
brew install fzf

log 'tealdeer as a fast tldr alternative'
brew install tealdeer

# disabled because has an error in stty
# see https://github.com/uutils/coreutils/issues/8608
#log 'uutils as a coreutils alternative'
#brew install uutils-coreutils

log 'zoxide as a cd alternative'
brew install zoxide
create_symlink "$(which zoxide)" "$HOME/.local/bin/cd"

log 'yq to process yaml, json, xml, csv'
brew install yq

log 'fastfetch to show system information'
brew install fastfetch

log 'bbrew a TUI for Brew'
brew install Valkyrie00/homebrew-bbrew/bbrew

to_dotfilesrc ". \"\$DOTFILES_PATH/terminal-tools/env\""
