#!/bin/bash

bash ~/dotfiles/symlink.sh

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    bash ~/dotfiles/macOS/setup.sh
elif [ "$OS" == "Linux" ]; then
    bash ~/dotfiles/ubuntu/setup.sh
fi

bash ~/dotfiles/jupyter_setup.sh

bash ~/dotfiles/prezto_setup.sh
bash ~/dotfiles/vimsetup.sh
