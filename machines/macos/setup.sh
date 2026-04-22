#!/usr/bin/env bash

echo -e "\nInitializing macOS setup..."

if ! command -v brew >/dev/null 2>&1; then
  echo -e "\nInstalling homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo -e "\nInstalling common brews..."
source ~/dotfiles/setup/brews.sh

# Modern brew: `brew install --cask <name>` replaces the deprecated
# `brew tap homebrew/cask` + `brew cask install`. Each app is installed only
# if not already present.
_cask_install() {
  if ! brew list --cask "$1" >/dev/null 2>&1; then
    brew install --cask "$1"
  fi
}

_cask_install iterm2
_cask_install anaconda

if ! command -v nvim >/dev/null 2>&1; then
  echo -e "\nInstalling nvim..."
  brew install nvim
fi

echo -e "\nFinishing git setup..."
brew link --overwrite git 2>/dev/null || true

# _cask_install java
# _cask_install intellij-idea

_cask_install flux
_cask_install google-chrome

_cask_install basictex
if [ -d /Library/TeX/texbin ]; then
  sudo tlmgr update --self 2>/dev/null || true
  sudo tlmgr install latexmk 2>/dev/null || true
  sudo tlmgr install texliveonfly 2>/dev/null || true
fi

_cask_install keka
_cask_install rectangle

echo -e "\nFinishing zsh setup..."
# Homebrew on Apple Silicon installs zsh under /opt/homebrew; Intel under /usr/local.
BREW_ZSH="$(brew --prefix 2>/dev/null)/bin/zsh"
if [ -x "$BREW_ZSH" ] && [ "$SHELL" != "$BREW_ZSH" ]; then
  # Make sure it's in /etc/shells before chsh'ing to it
  grep -qxF "$BREW_ZSH" /etc/shells 2>/dev/null || echo "$BREW_ZSH" | sudo tee -a /etc/shells >/dev/null
  chsh -s "$BREW_ZSH"
fi

echo -e "\nSyncing settings..."
cd ~/dotfiles/machines/macos/settings
source macOS.sh
source flux.sh
source safari.sh

echo -e "\nDone"
