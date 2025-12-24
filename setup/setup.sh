#!/usr/bin/env bash

cd ~/dotfiles

git submodule init
git submodule update

cd ~/dotfiles/submodules/k
git remote add upstream https://github.com/supercrabtree/k.git 2>/dev/null || true

source ~/dotfiles/setup/symlink.sh
source ~/dotfiles/setup/prezto/setup.sh
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# source ~/dotfiles/env/setup.sh

sudo apt-get install -y neovim eza
source ~/dotfiles/setup/vim.sh
source ~/dotfiles/setup/tmux.sh
# source ~/dotfiles/setup/jupyter/setup.sh
