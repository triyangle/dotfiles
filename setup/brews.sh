#!/usr/bin/env bash

# ==> Next steps:
# - Run `brew help` to get started
# - Further documentation: 
#     https://docs.brew.sh
# - Install the Homebrew dependencies if you have sudo access:
#   Debian, Ubuntu, etc.
#     sudo apt-get install build-essential
#   Fedora, Red Hat, CentOS, etc.
#     sudo yum groupinstall 'Development Tools'
#   See https://docs.brew.sh/linux for more information.
# - Configure Homebrew in your /home/triyangle/.profile by running
#     echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/triyangle/.profile
# - Add Homebrew to your PATH
#     eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# - We recommend that you install GCC by running:
#     brew install gcc

echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/triyangle/.profile
brew install gcc

echo -e "\nUpdating homebrew and homebrew cask..."
brew update

# echo -e "\nInstalling lua..."
# brew install lua

# echo -e "\nInstalling node..."
# brew install node

echo -e "\nInstalling git..."
brew install git

# echo -e "\nInstalling cmake..."
# brew install cmake
# 
# echo -e "\nInstalling ctags..."
# brew install ctags

# echo -e "\nInstalling gibo..."
# brew install gibo
# gibo -u

echo -e "\nInstalling fzf..."
/home/linuxbrew/.linuxbrew/opt/fzf/install
brew install fzf

echo -e "\nInstalling zsh..."
brew install zsh

echo -e "\nInstalling nvim..."
brew install neovim

echo -e "\nInstalling python..."
brew install python
