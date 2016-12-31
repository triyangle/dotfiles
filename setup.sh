#!/bin/bash

bash symlink.sh

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    bash macOS/setup.sh
elif [ "$OS" == "Linux" ]; then
    bash ubuntu/setup.sh
fi

bash prezto_setup.sh
bash vimsetup.sh
