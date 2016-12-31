#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export KEYTIMEOUT=1

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^k' backward-kill-line
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line

# OS specific settings
OS=`uname`
if [[ "$OS" == "Darwin" ]]; then
  bindkey '^[b' backward-word
  bindkey '^[f' forward-word
elif [[ "$OS" == "Linux" ]]; then
  bindkey '^[[1;5D' backward-word
  bindkey '^[[1;5C' forward-word

  fpath=(~/.zsh $fpath)
  autoload -U compinit && compinit 
fi
