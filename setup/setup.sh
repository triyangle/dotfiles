#!/usr/bin/env bash

source ~/dotfiles/setup/symlink.sh

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    source ~/dotfiles/macOS/setup.sh
elif [ "$OS" == "Linux" ]; then
    source ~/dotfiles/ubuntu/setup.sh
fi

source ~/dotfiles/setup/jupyter/setup.sh

source ~/dotfiles/setup/prezto/setup.sh
source ~/dotfiles/setup/vim.sh
