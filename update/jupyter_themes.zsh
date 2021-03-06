#!/usr/bin/env zsh

output=$(pip install --upgrade jupyterthemes)

if [[ $output != *"Requirement already up-to-date: jupyterthemes"* ]]; then
  source ~/dotfiles/setup/jupyter/theme.sh
else
  echo "Already up-to-date!"
fi
