#!/usr/bin/env bash

echo -e "\nInitializing Ona/Codespaces setup..."

sudo apt-get update -y
sudo apt-get install -y neovim eza fzf

sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

echo -e "\nDone"
