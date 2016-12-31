#!/bin/bash

bash symlink.sh

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    bash macOS/setup.sh
elif [ "$OS" == "Linux" ]; then
    bash ubuntu/setup.sh
fi

bash zsh_setup.sh
bash vimsetup.sh
