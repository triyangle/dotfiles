#!/bin/bash

echo -e "\nInitializing Ubuntu setup..."

sudo add-apt-repository ppa:webupd8team/java
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install synaptic byobu
sudo purge-old-kernels

echo -e "\nInstalling tmux..."
sudo apt-get install tmux

echo -e "\nInstalling git..."
sudo apt-get install git

echo -e "\nInstalling vim dependencies..."
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev git

echo -e "\nRemoving default versions..."
sudo apt-get remove vim vim-runtime gvim
sudo apt-get remove vim-tiny vim-common vim-gui-common vim-nox

echo -e "\nInstalling vim..."
cd ~
git clone https://github.com/vim/vim.git

cd ~/vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp \
            --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make && sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

echo -e "\nInstalling cmake..."
sudo apt-get install build-essential cmake

echo -e "\nInstalling exuberant-ctags..."
sudo apt-get install exuberant-ctags

echo -e "\nInstalling Python headers..."
sudo apt-get install python-dev python3-dev

echo -e "\nInstalling Java..."
sudo apt install oracle-java8-installer

echo -e "\nInstalling redshift..."
sudo apt-get install redshift-gtk

echo -e "\nInstalling gibo..."
sudo curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so /usr/bin/gibo && sudo chmod +x /usr/bin/gibo && gibo -u

echo -e "\nInstalling gibo zsh completions..."
mkdir ~/.zsh
sudo curl -L https://raw.githubusercontent.com/simonwhitaker/gibo/master/gibo-completion.zsh -so ~/.zsh/_gibo

echo -e "\nInstalling zsh..."
sudo apt-get install zsh
sudo chsh -s /usr/bin/zsh

echo ""
