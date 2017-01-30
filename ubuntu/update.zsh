#!/usr/bin/zsh

source /home/william/.zprofile
source /home/william/.zshrc

echo -e "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade

echo -e "\nUpdating brews..."
source ~/dotfiles/brew_update.zsh
brew upgrade

echo -e "\nUpdating vim..."
cd ~/vim
git pull

sudo make uninstall
make distclean
source ~/dotfiles/ubuntu/vim_install.sh

source ~/dotfiles/common_update.zsh

echo -e "\nCleaning..."
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
sudo purge-old-kernels
echo -e "Done"
