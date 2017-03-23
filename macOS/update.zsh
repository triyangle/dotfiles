#!/usr/bin/env zsh

source /Users/William/.zprofile
source /Users/William/.zshrc
source /Users/William/.zlogin

source ~/dotfiles/brew_update.zsh

(set -x; brew cask cleanup;)

echo ""

(set -x; brew upgrade vim --with-python3;)

echo ""

(set -x; brew upgrade;)

echo ""

brew cu -y

source ~/dotfiles/common_update.zsh

echo ""
