#!/usr/local/bin/zsh

echo "Updating brew..."

(set -x; /usr/local/bin/brew update;)

echo -e "\nCleaninup up brew..."

(set -x; /usr/local/bin/brew cleanup;)
echo -e "\nCleaning up cask..."
(set -x; /usr/local/bin/brew cask cleanup;)
echo -e "\nUpgrading brews..."

(set -x; /usr/local/bin/brew upgrade vim --with-custom-python;)
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

echo -e "\nUpdating prezto..."
cd /Users/William/.zprezto
/usr/local/bin/git pull && /usr/local/bin/git submodule update --init --recursive
/usr/local/bin/git pull upstream master
/usr/local/bin/git submodule foreach /usr/local/bin/git pull origin master

echo -e "\nUpdating statusline..."
cd /Users/William/.zprezto/modules/prompt/external/statusline
/usr/local/bin/git pull upstream master

echo -e "\nUpdating submodules..."
cd /Users/William/dotfiles
/usr/local/bin/git submodule foreach /usr/local/bin/git pull origin master

echo -e "\nUpdating Powerline fonts..."
cd /Users/William/dotfiles/fonts
/usr/local/bin/git pull
./install.sh

echo -e "\nUpdating anaconda..."
/Users/William/anaconda3/bin/conda update anaconda -y

echo -e "\nUpdating conda packages..."
/Users/William/anaconda3/bin/conda update --all -y

echo -e "\nUpdating pip packages..."
/Users/William/anaconda3/bin/pip freeze --local | /usr/bin/grep -v '^\-e' | /usr/bin/cut -d = -f 1  | /usr/bin/xargs -n1 /Users/William/anaconda3/bin/pip install -U

echo -e "\nUpdating jupyter vim mode..."
cd /Users/William/vim_binding
/usr/local/bin/git pull

echo -e "\nUpdating gibo..."
/usr/local/bin/gibo -u

echo -e "\nUpdating vim plugins..."
(set -x; /usr/local/bin/vim +"PlugUpdate YouCompleteMe" +PlugUpdate +qall;)

echo ""
