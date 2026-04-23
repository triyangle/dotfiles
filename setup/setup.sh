#!/usr/bin/env bash

cd ~/dotfiles

# Env detection
if [ "$IS_ON_ONA" = "true" ] || [ -n "$CODESPACES" ]; then
  DOTFILES_ENV=ona
elif [ "$(uname -s)" = "Darwin" ]; then
  DOTFILES_ENV=macos
else
  echo "ERROR: Unknown environment. Set IS_ON_ONA=true (Ona) or run on macOS." >&2
  return 1 2>/dev/null || exit 1
fi
echo "$DOTFILES_ENV" > ~/.dotfiles-env
export DOTFILES_ENV
echo "Detected env: $DOTFILES_ENV"

git submodule init
git submodule update

git -C ~/dotfiles/submodules/k remote add upstream https://github.com/supercrabtree/k.git 2>/dev/null || true

source ~/dotfiles/setup/symlink.sh
source ~/dotfiles/setup/prezto/setup.sh

# Env-specific package installs / shell change
source ~/dotfiles/machines/"$DOTFILES_ENV"/setup.sh

source ~/dotfiles/setup/vim.sh
source ~/dotfiles/setup/tmux.sh
# source ~/dotfiles/setup/jupyter/setup.sh
