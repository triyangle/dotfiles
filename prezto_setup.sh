echo -e "\nInstalling prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
zsh ~/dotfiles/prezto.zsh
chsh -s /usr/local/bin/zsh

echo -e "\nInstalling Powerline fonts..."
cd ~
git clone https://github.com/powerline/fonts.git
cd ~/fonts
./install.sh
