#!/bin/bash

echo -e "Initializing macOS setup..."

echo -e "\nInstalling homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo -e "\nInstalling homebrew cask..."
brew tap caskroom/cask

echo -e "\nUpdating homebrew and homebrew cask..."
brew update

echo -e "\nInstalling iTerm 2..."
brew cask install iterm2

echo -e "\nInstalling Python3..."
brew install python3
brew linkapps python3

echo -e "\nInstalling vim..."
brew install vim --with-custom-python

echo -e "\nInstalling git..."
brew install git
brew link git

echo -e "\nInstalling cmake..."
brew install cmake

echo -e "\nInstalling ctags..."
brew install ctags

echo -e "\nInstalling Java..."
brew cask install java

echo -e "\nInstalling IntelliJ..."
brew tap caskroom/versions
brew cask install intellij-idea-ce

echo -e "\nInstalling flux..."
brew cask install flux

echo -e "\nSetting up crontab file..."
crontab crontab.txt

echo -e "\nInstalling zsh..."
brew install zsh zsh-completions

echo -e "\nInstalling prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
zsh ~/dotfiles/prezto.zsh
chsh -s /usr/local/bin/zsh

echo -e "\nInstalling Powerline fonts..."
cd ~
git clone https://github.com/powerline/fonts.git
cd ~/fonts
./install.sh

echo ""
