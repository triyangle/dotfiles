#!/usr/bin/env zsh

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

echo -e "\nUpdating conda packages & anaconda..."
conda update -y conda
conda update -y anaconda
conda update -yc conda-forge jupyter_contrib_nbextensions

echo -e "\nUpdating pip packages..."
pip install --upgrade jupyterthemes datascience okpy mpld3 plotly

echo -e "\nUpdating jupyter theme..."
bash ~/dotfiles/jupyter_theme.sh

echo -e "\nUpdating jupyter vim mode..."
cd $(jupyter --data-dir)/nbextensions/vim_binding
git pull

echo -e "\nUpdating gibo..."
gibo -u

echo -e "\nUpdating npm packages..."
npm update -g

echo -e "\nUpdating TeX..."
tlmgr update --self
tlmgr update --all

echo -e "\nUpdating vim plugins..."
vim +PlugUpgrade +"PlugUpdate YouCompleteMe" +PlugUpdate +PlugClean! +qall
