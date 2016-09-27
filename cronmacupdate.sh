#!/bin/bash

echo "Updating brew..."

(set -x; /usr/local/bin/brew update;)

echo -e "\nCleaninup up brew..."

(set -x; /usr/local/bin/brew cleanup;)
echo -e "\nCleaning up cask..."
(set -x; /usr/local/bin/brew cask cleanup;)
echo -e "\nUpgrading brews..."

(set -x; /usr/local/bin/brew upgrade vim --with-python3;)
(set -x; /usr/local/bin/brew upgrade;)

echo -e "\nUpgrading casks..."

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

casks=( $(/usr/local/bin/brew cask list) )

for cask in ${casks[@]}
do
    installed="$(/usr/local/bin/brew cask info $cask | grep 'Not installed')"

    if [[ $installed = *[!\ ]* ]]; then
        echo "${red}${cask}${reset} requires ${red}update${reset}."
        (set -x; /usr/local/bin/brew cask uninstall $cask --force;)
        (set -x; /usr/local/bin/brew cask install $cask --force;)
    else 
        echo "${red}${cask}${reset} is ${green}up-to-date${reset}."
    fi
done

echo -e "\nUpdating vim plugins..."
(set -x; /usr/local/bin/vim +PluginUpdate +qall;)

echo ""
