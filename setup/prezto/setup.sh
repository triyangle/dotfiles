#!/usr/bin/env bash

echo -e "\nInstalling prezto..."
git clone --recurse-submodules https://github.com/triyangle/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
source ~/dotfiles/setup/prezto/init.zsh
cd ~/.zprezto
git submodule update --init --recursive
git remote set-url --add origin https://triyangle@bitbucket.org/triyangle/prezto.git
git remote add upstream https://github.com/sorin-ionescu/prezto.git

cd ~/.zprezto/modules/prompt/external/statusline
git remote set-url --add origin https://triyangle@bitbucket.org/triyangle/statusline.git
git remote add upstream https://github.com/el1t/statusline.git

echo -e "\nInstalling Powerline fonts..."
cd ~/dotfiles/submodules/fonts
./install.sh
