#!/bin/bash

OS=`uname`

if [ "$OS" == "Darwin" ]; then
    bash macsetup.sh
fi

bash vimsetup.sh

