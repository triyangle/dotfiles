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
git pull
./install.sh

echo -e "\nUpdating anaconda..."
conda update anaconda

echo -e "\nUpdating conda packages..."
conda update --all

echo -e "\nUpdating pip packages..."
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

echo -e "\nUpdating jupyter vim mode..."
cd ~/vim_binding
git pull

echo -e "\nUpdating gibo..."
gibo -u

echo -e "\nUpdating vim plugins..."
vim +"PlugUpdate YouCompleteMe" +PlugUpdate
