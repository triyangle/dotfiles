#!/usr/bin/env bash

echo -e "\nInitializing symlinking..."

dir=~/dotfiles
# olddir=~/dotfiles_old
# files=(.vimrc .ideavimrc .gitignore_global .jupyter)

# echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
# mkdir -p $olddir
# echo "done"

echo -e "\nChanging to the $dir directory..."
cd $dir
echo "Done"

ln -sf ~/dotfiles/config/home/.* ~/

ln -sf ~/dotfiles/config/nvim ~/.config/nvim

# for file in "${files[@]}"; do
    # echo "Moving any existing dotfiles from ~ to $olddir"
    # mv ~/.$file ~/dotfiles_old/
    # echo -e "\nCreating symlink to $file in home directory..."
    # ln -s $dir/$file ~
# done

ln -sf ~/dotfiles/env/config/.* ~/

echo -e "\nSymlinking vim spell"
mkdir -p ~/.vim
ln -sf ~/dotfiles/config/.vim/spell ~/.vim/

# echo -e "\nSymlinking gemini"
# mkdir -p ~/.gemini
# ln -s ~/dotfiles/config/.gemini/settings.json ~/.gemini/


echo -e "\nSymlinking codex"
mkdir -p ~/.codex
ln -sf ~/dotfiles/config/.codex/config.toml ~/.codex/

echo -e "\nSymlinking ipython profile"
mkdir -p ~/.ipython/profile_default
ln -sf ~/dotfiles/config/.ipython/profile_default/* ~/.ipython/profile_default/

# echo -e "\nSymlinking Rectangle config file"
# ln -s ~/dotfiles/env/settings/rectangle/com.knollsoft.Rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist

echo -e "\nSetting up crontab..."
crontab ~/dotfiles/env/config/crontab
echo "Done"
