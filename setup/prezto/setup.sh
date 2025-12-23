#!/usr/bin/env bash

echo -e "\nInstalling prezto..."
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recurse-submodules https://github.com/triyangle/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
source ~/dotfiles/setup/prezto/init.zsh
cd ~/.zprezto
git submodule update --init --recursive
git remote set-url origin git@github.com:triyangle/prezto.git
git remote add upstream https://github.com/sorin-ionescu/prezto.git 2>/dev/null || true

cd ~/.zprezto/modules/prompt/external/statusline
git remote set-url origin git@github.com:triyangle/statusline.git
git remote add upstream https://github.com/el1t/statusline.git 2>/dev/null || true

echo -e "\nInstalling Powerline fonts..."
cd ~/dotfiles/submodules/fonts
./install.sh
