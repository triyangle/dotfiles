#!/bin/bash

echo -e "Updating vim..."
cd ~/vim
(set -x; git pull;)

echo -e "\nUpdating vim plugins..."
(set -x; /usr/bin/vim +PluginUpdate +qall;)

echo -e "\nUpdating prezto..."
cd ~/.zprezto
git pull && git submodule update --init --recursive

echo -e "\nUpdating Powerline fonts..."
cd ~/fonts
git pull


