#!/bin/bash

echo -e "\nInitializing symlinking..."

dir=~/dotfiles
# olddir=~/dotfiles_old
files=".vimrc .ideavimrc .gitignore_global .zpreztorc .zprofile .zshrc"

# echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
# mkdir -p $olddir
# echo "done"

echo -e "\nChanging to the $dir directory..."
cd $dir
echo "Done"

for file in $files; do
    # echo "Moving any existing dotfiles from ~ to $olddir"
    # mv ~/.$file ~/dotfiles_old/
    echo -e "\nCreating symlink to $file in home directory..."
    ln -s $dir/$file ~/$file
done

OS=`uname`
specific_files=".gitconfig"

if [ "$OS" == "Darwin" ]; then
    specific_dir=~/dotfiles/macOS
elif [ "$OS" == "Linux" ]; then
    specific_dir=~/dotfiles/ubuntu
fi

for specific_file in $specific_files; do
    echo -e "\nCreating symlink to $specific_file in home directory..."
    ln -s $specific_dir/$specific_file ~/$specific_file
done

echo -e "\nSetting up crontab..."
crontab $specific_dir/crontab
echo "Done"
