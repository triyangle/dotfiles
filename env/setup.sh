#!/usr/bin/env bash

echo -e "\nInitializing macOS setup..."

echo -e "\nInstalling homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# need to fix this (after running prev. line to install homebrew, the brew cmd
# is not yet available): /Users/williamyang/dotfiles/setup/brews.sh:4: command not found: brew
echo -e "\nInstalling common brews..."
source ~/dotfiles/setup/brews.sh

echo -e "\nInstalling homebrew cask..."
brew tap homebrew/cask

echo -e "\nInstalling iTerm 2..."
brew cask install iterm2

echo -e "\nInstalling Anaconda..."
brew cask install anaconda

echo -e "\nInstalling nvim..."
brew install nvim

echo -e "\nFinishing git setup..."
brew link git

# echo -e "\nInstalling Java..."
# brew cask install java

# echo -e "\nInstalling IntelliJ..."
# brew cask install intellij-idea

echo -e "\nInstalling flux..."
brew cask install flux

echo -e "\nInstalling Google Chrome..."
brew cask install google-chrome

echo -e "\nInstalling BasicTeX..."
brew cask install basictex
sudo chmod -R 755 /Users/William/Library/texlive
sudo tlmgr update --self
sudo tlmgr install latexmk
sudo tlmgr install texliveonfly

echo -e "\nInstalling Skype..."
brew cask install skype

echo -e "\nInstalling keka..."
brew cask install keka

echo -e "\nInstalling rectangle..."
brew cask install rectangle

echo -e "\nFinishing zsh setup..."
chsh -s /usr/local/bin/zsh
echo "Done"

echo -e "\nSyncing settings..."
cd ~/dotfiles/env/settings
source macOS.sh
source flux.sh
source safari.sh
echo -e "\nDone"

echo ""
