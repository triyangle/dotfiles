#!/usr/local/bin/zsh

(set -x; brew update;)

echo ""

(set -x; brew cleanup;)
echo ""
(set -x; brew cask cleanup;)
echo ""

(set -x; brew upgrade vim --with-custom-python;)

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

echo -e "\nUpdating prezto..."
cd ~/.zprezto
git pull && git submodule update --init --recursive

echo -e "\nUpdating Powerline fonts..."
cd ~/fonts
git pull

echo -e "\nUpdating gibo..."
gibo -u

echo -e "\nUpdating vim plugins..."
vim +PluginUpdate

echo ""
