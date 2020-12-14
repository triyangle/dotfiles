#!/usr/bin/env bash

echo -e "\nUpdating homebrew and homebrew cask..."
brew update

# echo -e "\nInstalling lua..."
# brew install lua

echo -e "\nInstalling node..."
brew install node

echo -e "\nInstalling git..."
brew install git

echo -e "\nInstalling cmake..."
brew install cmake

echo -e "\nInstalling ctags..."
brew install ctags

# echo -e "\nInstalling gibo..."
# brew install gibo
# gibo -u

echo -e "\nInstalling fzf..."
brew install fzf
$(brew --prefix)/opt/fzf/install

echo -e "\nInstalling fasd..."
brew install fasd

echo -e "\nInstalling zsh..."
brew install zsh
