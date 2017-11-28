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

# for file in "${files[@]}"; do
    # echo "Moving any existing dotfiles from ~ to $olddir"
    # mv ~/.$file ~/dotfiles_old/
    # echo -e "\nCreating symlink to $file in home directory..."
    # ln -s $dir/$file ~
# done

ln -s ~/dotfiles/env/config/.* ~/

echo -e "\nSymlinking vim spell"
mkdir -p ~/.vim
ln -s ~/dotfiles/config/.vim/spell ~/.vim/

echo -e "\nSymlinking ipython profile"
mkdir -p ~/.ipython/profile_default
ln -s ~/dotfiles/config/.ipython/profile_default/* ~/.ipython/profile_default/

echo -e "\nSetting up crontab..."
crontab $specific_dir/crontab
echo "Done"
