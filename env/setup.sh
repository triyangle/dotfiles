#!/usr/bin/env bash

echo -e "\nInitializing Ubuntu setup..."

echo -e "\nInstalling Linuxbrew..."
# sudo apt-get install build-essential curl git python-setuptools ruby
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

echo -e "\nInstalling common brews..."
source ~/dotfiles/setup/brews.sh

# sudo add-apt-repository ppa:webupd8team/java
# sudo apt-get update && sudo apt-get upgrade
# sudo apt-get install synaptic byobu
# sudo purge-old-kernels

echo -e "\nInstalling tmux..."
brew install tmux

# echo -e "\nInstalling vim dependencies..."
# sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
#     libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
#     libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
#     python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git

# echo -e "\nRemoving default versions..."
# sudo apt-get remove vim vim-runtime gvim
# sudo apt-get remove vim-tiny vim-common vim-gui-common vim-nox

# echo -e "\nInstalling vim..."
# cd ~
# git clone https://github.com/vim/vim.git
# source ~/dotfiles/env/vim/install.sh

# echo -e "\nInstalling Java..."
# sudo apt install oracle-java8-installer

# echo -e "\nInstalling IntelliJ..."
# brew install athrunsun/linuxbinary/intellij-idea

# echo -e "\nInstalling redshift..."
# sudo apt-get install redshift-gtk

# echo -e "\nInstalling TexLive..."
# brew install texlive

# echo -e "\nFinishing zsh setup..."
# sudo cp ~/.linuxbrew/bin/zsh /usr/bin/zsh
# sudo chsh -s /usr/bin/zsh
# echo "Done"

echo ""
