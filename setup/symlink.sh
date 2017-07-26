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

OS=`uname`

if [[ "$OS" == "Darwin" ]]; then
    # specific_files=(.gitconfig)
    specific_dir=~/dotfiles/macOS/config
elif [[ "$OS" == "Linux" ]]; then
    ln -s ~/dotfiles/submodules/dircolors-solarized/dircolors.ansi-dark ~/.dircolors
    # specific_files=(.gitconfig .tmux.conf)
    specific_dir=~/dotfiles/ubuntu/config
fi

# for specific_file in "${specific_files[@]}"; do
#     echo -e "\nCreating symlink to $specific_file in home directory..."
#     ln -s $specific_dir/$specific_file ~
# done

ln -s $specific_dir/.* ~/

echo -e "\nSymlinking vim spell"
ln -s ~/dotfiles/config/.vim/spell ~/.vim/

echo -e "\nSymlinking ipython profile"
ln -s ~/dotfiles/config/.ipython/profile_default/* ~/.ipython/profile_default/

echo -e "\nSetting up crontab..."
crontab $specific_dir/crontab
echo "Done"
