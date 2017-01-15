#!/bin/bash

echo -e "\nInitializing Ubuntu setup..."

echo -e "\nInstalling Linuxbrew..."
sudo apt-get install build-essential curl git python-setuptools ruby
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

echo -e "\nInstalling common brews..."
bash ~/dotfiles/common_brews.sh

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install synaptic byobu
sudo purge-old-kernels

echo -e "\nInstalling tmux..."
brew install tmux

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
            --with-python3-config-dir=/home/william/.linuxbrew/Cellar/python3/3.6.0/lib/python3.6/config-3.6m-x86_64-linux-gnu \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make && sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

echo -e "\nInstalling Java..."
sudo apt install oracle-java8-installer

echo -e "\nInstalling redshift..."
sudo apt-get install redshift-gtk

echo -e "\nFinishing zsh setup..."
sudo cp ~/.linuxbrew/bin/zsh /usr/bin/zsh
sudo chsh -s /usr/bin/zsh
echo "Done"

echo ""
