#!/bin/bash

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    bash macsetup.sh
elif [ "$OS" == "Linux" ]; then
    bash ubuntusetup.sh
fi

bash vimsetup.sh
