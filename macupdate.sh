#!/bin/bash

(set -x; brew update;)

echo ""

(set -x; brew cleanup;)
echo ""
(set -x; brew cask cleanup;)
echo ""

(set-x; brew upgrade vim --with-python3;)

echo ""

(set -x; brew upgrade;)

echo ""

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

casks=( $(brew cask list) )

for cask in ${casks[@]}
do
    installed="$(brew cask info $cask | grep 'Not installed')"

    if [[ $installed = *[!\ ]* ]]; then
        echo "${red}${cask}${reset} requires ${red}update${reset}."
        (set -x; brew cask uninstall $cask --force;)
        (set -x; brew cask install $cask --force;)
    else 
        echo "${red}${cask}${reset} is ${green}up-to-date${reset}."
    fi
done

echo -e "\nUpdating vim plugins..."
vim +PluginUpdate

echo ""
