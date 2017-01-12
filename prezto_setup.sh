echo -e "\nInstalling prezto..."
git clone --recursive https://github.com/triyangle/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
zsh ~/dotfiles/prezto.zsh

echo -e "\nInstalling Powerline fonts..."
cd ~
git clone https://github.com/powerline/fonts.git
cd ~/fonts
./install.sh
