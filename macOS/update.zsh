#!/usr/bin/env zsh

source $HOME/.zprofile
source $HOME/.zshrc
source $HOME/.zlogin

source ~/dotfiles/update/brew.zsh

(set -x; brew cask cleanup;)

echo ""

(set -x; brew upgrade vim --with-python3;)

echo ""

(set -x; brew upgrade;)

echo ""

echo -e "\nUpgrading casks..."
source ~/dotfiles/submodules/cask_upgrade/cask_upgrade.sh

source ~/dotfiles/update/common.zsh

echo ""
