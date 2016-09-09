#!/bin/bash

echo -e "Initializing macOS setup..."

echo -e "\nInstalling homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo -e "\nInstalling homebrew cask..."
brew tap caskroom/cask

echo -e "\nUpdating homebrew and homebrew cask..."
brew update

echo -e "\nInstalling Python3..."
brew install python3
brew linkapps python3

echo -e "\nInstalling vim..."
brew install vim --with-python3

echo -e "\nInstalling git..."
brew install git
brew link git

echo -e "\nInstalling cmake..."
brew install cmake

echo -e "\nInstalling Java..."
brew cask install java

echo -e "\nInstalling Eclipse..."
brew cask install eclipse-installer

echo ""
