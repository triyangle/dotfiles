#!/bin/bash

echo -e "\nUpdating homebrew and homebrew cask..."
brew update

echo -e "\nInstalling Python3..."
brew install python3

echo -e "\nInstalling git..."
brew install git

echo -e "\nInstalling cmake..."
brew install cmake

echo -e "\nInstalling ctags..."
brew install ctags

echo -e "\nInstalling gibo..."
brew install gibo

echo -e "\nInstalling zsh..."
brew install zsh
