#!/usr/bin/env zsh

source /home/will/.zprofile
source /home/will/.zshrc
source /home/will/.zlogin

echo -e "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade

echo -e "\nUpdating brews..."
source ~/dotfiles/brew_update.zsh
brew upgrade

echo -e "\nUpdating vim..."
source ~/dotfiles/ubuntu/vim_update.zsh

source ~/dotfiles/common_update.zsh

echo -e "\nCleaning..."
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
sudo purge-old-kernels

echo -e "Done"
