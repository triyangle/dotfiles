#!/usr/bin/env zsh

cd ~/vim

git remote update

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [[ $LOCAL = $REMOTE ]]; then
  echo "Up-to-date"
elif [[ $LOCAL = $BASE ]]; then
  git pull
  sudo make uninstall
  make distclean
  source ~/dotfiles/env/vim/install.sh
elif [[ $REMOTE = $BASE ]]; then
  echo "Need to push"
else
  echo "Diverged"
fi
