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

if [ "$OS" == "Darwin" ]; then
    cat macgitconfig > ~/.gitconfig
elif [ "$OS" == "Linux" ]; then
    cat ubuntugitconfig > ~/.gitconfig
fi

