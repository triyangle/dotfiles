#!/bin/bash

echo -e "\nInitializing macOS setup..."

echo -e "\nInstalling homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo -e "\nInstalling common brews..."
bash ~/dotfiles/common_brews.sh

echo -e "\nInstalling homebrew cask..."
brew tap caskroom/cask

echo -e "\nInstalling iTerm 2..."
brew cask install iterm2

echo -e "\nFinishing Python 3 setup..."
brew linkapps python3

echo -e "\nInstalling Anaconda..."
brew cask install anaconda

echo -e "\nSetting up Jupyter notebook..."
conda install -c conda-forge jupyter_contrib_nbextensions
mkdir -p $(jupyter --data-dir)/nbextensions
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
chmod -R go-w vim_binding

pip install jupyterthemes
jt -t onedork -vim -T -N

echo -e "\nInstalling vim..."
brew install vim --with-custom-python

echo -e "\nFinishing git setup..."
brew link git

echo -e "\nInstalling Java..."
brew cask install java

echo -e "\nInstalling IntelliJ..."
brew cask install intellij-idea

echo -e "\nInstalling flux..."
brew cask install flux

echo -e "\nInstalling Skype..."
brew cask install skype

echo -e "\nFinishing zsh setup..."
chsh -s /usr/local/bin/zsh
echo "Done"

echo -e "\nSyncing settings..."
bash ~/dotfiles/macOS/settings/macOS.sh
bash ~/dotfiles/macOS/settings/flux.sh
bash ~/dotfiles/macOS/settings/safari.sh
tic -o ~/.terminfo ~/dotfiles/macOS/settings/xterm-256color.terminfo
echo -e "\nDone"

echo ""
