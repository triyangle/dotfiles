#!/bin/bash

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    bash macsetup.sh
elif [ "$OS" == "Linux" ]; then
    bash ubuntusetup.sh
fi

bash vimsetup.sh

if [ "$OS" == "Linux" ]; then
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
    sudo update-alternatives --set vi /usr/bin/vim
fi
