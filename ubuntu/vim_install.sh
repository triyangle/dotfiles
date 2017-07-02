#!/usr/bin/env bash

cd ~/vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --enable-python3interp \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make && sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
