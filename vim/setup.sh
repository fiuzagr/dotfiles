#!/usr/bin/env sh

brew install vim

curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

create_symlink "$DOTFILES_PATH/vim/.vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_PATH/vim/.ideavimrc" "$HOME/.ideavimrc"
