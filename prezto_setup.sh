echo -e "\nConfiguring prezto..."
zsh ~/dotfiles/prezto.zsh
cd ~/.zprezto
git remote set-url --add origin https://triyangle@bitbucket.org/triyangle/prezto.git
git remote add upstream https://github.com/zsh-users/prezto.git

cd ~/.zprezto/modules/prompt/external/statusline
git remote set-url --add origin https://triyangle@bitbucket.org/triyangle/statusline.git
git remote add upstream https://github.com/el1t/statusline.git

echo -e "\nInstalling Powerline fonts..."
cd ~/dotfiles/fonts
./install.sh
