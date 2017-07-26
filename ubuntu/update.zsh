#!/usr/bin/env zsh

source $HOME/.zprofile
source $HOME/.zshrc
source $HOME/.zlogin

echo -e "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade

echo -e "\nUpdating brews..."
source ~/dotfiles/update/brew.zsh
brew upgrade

echo -e "\nUpdating vim..."
source ~/dotfiles/ubuntu/vim/update.zsh

source ~/dotfiles/update/common.zsh

echo -e "\nCleaning..."
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
sudo purge-old-kernels

echo -e "Done"
