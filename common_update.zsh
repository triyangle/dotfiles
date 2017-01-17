#!/usr/local/bin/zsh

echo -e "\nUpdating prezto..."
cd ~/.zprezto
git pull && git submodule update --init --recursive
git pull upstream master
git submodule foreach git pull origin master

echo -e "\nUpdating statusline..."
cd ~/.zprezto/modules/prompt/external/statusline
git pull upstream master

echo -e "\nUpdating submodules..."
cd ~/dotfiles
git submodule foreach git pull origin master

echo -e "\nUpdating powerline fonts..."
cd ~/dotfiles/fonts
./install.sh

echo -e "\nUpdating gibo..."
gibo -u

echo -e "\nUpdating vim plugins..."
vim +"PlugUpdate YouCompleteMe" +PlugUpdate
