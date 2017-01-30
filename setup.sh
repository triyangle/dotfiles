#!/bin/bash

source ~/dotfiles/symlink.sh

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    source ~/dotfiles/macOS/setup.sh
elif [ "$OS" == "Linux" ]; then
    source ~/dotfiles/ubuntu/setup.sh
fi

source ~/dotfiles/jupyter_setup.sh

source ~/dotfiles/prezto_setup.sh
source ~/dotfiles/vimsetup.sh
