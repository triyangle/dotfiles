#!/usr/bin/env bash

echo -e "\nInitializing Ona/Codespaces setup..."

sudo apt-get update -y
sudo apt-get install -y neovim eza fzf cmake build-essential python3-dev

sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

echo -e "\nDone"
