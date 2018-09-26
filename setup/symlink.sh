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

ln -s ~/dotfiles/config/home/.* ~/

ln -s ~/dotfiles/config/nvim ~/.config/nvim

# for file in "${files[@]}"; do
    # echo "Moving any existing dotfiles from ~ to $olddir"
    # mv ~/.$file ~/dotfiles_old/
    # echo -e "\nCreating symlink to $file in home directory..."
    # ln -s $dir/$file ~
# done

# for specific_file in "${specific_files[@]}"; do
#     echo -e "\nCreating symlink to $specific_file in home directory..."
#     ln -s $specific_dir/$specific_file ~
# done

ln -s ~/dotfiles/env/config/.* ~/

echo -e "\nSymlinking vim spell"
mkdir -p ~/.vim
ln -s ~/dotfiles/config/.vim/spell ~/.vim/

echo -e "\nSymlinking ipython profile"
mkdir -p ~/.ipython/profile_default
ln -s ~/dotfiles/config/.ipython/profile_default/* ~/.ipython/profile_default/

echo -e "\nSetting up crontab..."
# crontab ~/dotfiles/env/config/crontab
echo "Done"
