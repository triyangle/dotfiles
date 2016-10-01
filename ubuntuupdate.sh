#!/bin/bash

echo -e "Updating vim..."
cd ~/vim
(set -x; git pull;)

echo -e "\nUpdating vim plugins..."
(set -x; /usr/bin/vim +PluginUpdate +qall;)
