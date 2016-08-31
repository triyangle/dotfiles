#!/bin/bash

bash symlink.sh

echo "Retrieving Vundle from GitHub"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing vim plugins"
vim +PluginInstall +qall

echo "YouCompleteMe setup"
cd ~/.vim/bundle/YouCompleteMe
./install.py --all
