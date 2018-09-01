#!/usr/bin/env bash

cd ~/dotfiles
git submodule init
git submodule update

cd ~/dotfiles/submodules/k
git remote add upstream https://github.com/supercrabtree/k.git

source ~/dotfiles/setup/symlink.sh
source ~/dotfiles/setup/prezto/setup.sh

source ~/dotfiles/env/setup.sh

source ~/dotfiles/setup/vim.sh
source ~/dotfiles/setup/tmux.sh
# source ~/dotfiles/setup/jupyter/setup.sh
