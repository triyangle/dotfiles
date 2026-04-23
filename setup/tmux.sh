#!/usr/bin/env bash

# terminfo (italics-capable tmux entries)
tic -xo ~/.terminfo ~/dotfiles/config/tmux/xterm-256color-italic.terminfo 2>/dev/null
tic -xo ~/.terminfo ~/dotfiles/config/tmux/tmux-256color.terminfo 2>/dev/null

# TPM (tmux plugin manager) + plugins declared in ~/.tmux.conf
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo -e "\nCloning TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  echo -e "\nInstalling tmux plugins via TPM..."
  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi
