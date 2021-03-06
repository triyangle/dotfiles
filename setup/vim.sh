#!/usr/bin/env bash
echo -e "Initiliazing vim setup..."

echo -e "\nRetrieving vim-plug from GitHub..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\nInstalling nvim plugins..."
nvim +"PlugInstall YouCompleteMe" +PlugInstall +qall

pip install neovim

# echo -e "\nInstalling instant-markdown..."
# npm -g install instant-markdown-d

echo ""
