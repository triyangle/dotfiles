#!/usr/bin/env zsh

source $HOME/.zprofile
source $HOME/.zshrc
source $HOME/.zlogin

source ~/dotfiles/update/brew.zsh

(set -x; brew upgrade;)

echo ""

echo -e "\nUpgrading casks..."
brew cask upgrade

source ~/dotfiles/update/common.zsh

echo ""
