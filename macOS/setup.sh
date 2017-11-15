#!/usr/bin/env bash

echo -e "\nInitializing macOS setup..."

echo -e "\nInstalling homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo -e "\nInstalling common brews..."
source ~/dotfiles/setup/brews.sh

echo -e "\nInstalling homebrew cask..."
brew tap caskroom/cask

echo -e "\nInstalling iTerm 2..."
brew cask install iterm2

echo -e "\nInstalling Anaconda..."
brew cask install anaconda

echo -e "\nInstalling vim..."
brew install vim

echo -e "\nFinishing git setup..."
brew link git

echo -e "\nInstalling Java..."
brew cask install java

echo -e "\nInstalling IntelliJ..."
brew cask install intellij-idea

echo -e "\nInstalling flux..."
brew cask install flux

echo -e "\nInstalling Google Chrome..."
brew cask install google-chrome

echo -e "\nInstalling MacTeX..."
brew cask install mactex

echo -e "\nInstalling Skype..."
brew cask install skype

echo -e "\nFinishing zsh setup..."
chsh -s /usr/local/bin/zsh
echo "Done"

echo -e "\nSyncing settings..."
cd ~/dotfiles/macOS/settings
source macOS.sh
source flux.sh
source safari.sh
echo -e "\nDone"

echo ""
