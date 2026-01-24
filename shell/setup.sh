#!/usr/bin/env sh

shell_type=$(get_shell)

case "$shell_type" in
  zsh)
    create_symlink "$DOTFILES_PATH/shell/zsh/.zshrc" "$HOME/.zshrc"
    ;;
esac

to_dotfilesrc '. "$DOTFILES_PATH/shell/common/env"'
to_dotfilesrc '. "$DOTFILES_PATH/shell/'"$shell_type"'/env"'
