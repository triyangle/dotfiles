#!/bin/bash

echo -e "Initiliazing vim setup..."

bash symlink.sh

echo -e "\nRetrieving Vundle from GitHub..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo -e "\nInstalling vim plugins..."
vim +PluginInstall +qall

echo -e "\nYouCompleteMe setup..."
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

echo ""
