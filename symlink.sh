#!/bin/bash

dir=~/dotfiles
# olddir=~/dotfiles_old
files=".vimrc"

# echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
# mkdir -p $olddir
# echo "done"

echo "Changing to the $dir directory..."
cd $dir
echo "Done"

for file in $files; do
    # echo "Moving any existing dotfiles from ~ to $olddir"
    # mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

