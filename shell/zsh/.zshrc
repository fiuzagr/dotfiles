# Zsh configuration for dotfiles

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups

# Enable completion
autoload -Uz compinit && compinit

# Source dotfiles configuration
[ -f "$HOME/.dotfilesrc" ] && . "$HOME/.dotfilesrc"
