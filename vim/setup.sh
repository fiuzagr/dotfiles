#!/usr/bin/env sh

brew install vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf "$DOTFILES_PATH/vim/.vimrc" ~/.vimrc
ln -sf "$DOTFILES_PATH/vim/.ideavimrc" ~/.ideavimrc

sed -i "s|let \$VIM_DOTFILES_PATH.*|let \$VIM_DOTFILES_PATH='$DOTFILES_PATH/vim'|" ~/.vimrc
