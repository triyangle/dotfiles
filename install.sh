#!/usr/bin/env bash
# Entry point discovered by Codespaces/Ona's dotfiles auto-runner.
# Ensures ~/dotfiles resolves to this repo, then dispatches to setup/setup.sh.

set -e

SELF=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ "$SELF" != "$HOME/dotfiles" ]; then
  if [ -e "$HOME/dotfiles" ] && [ ! -L "$HOME/dotfiles" ]; then
    echo "ERROR: $HOME/dotfiles exists as non-symlink; remove it and retry." >&2
    exit 1
  fi
  ln -sfn "$SELF" "$HOME/dotfiles"
fi

exec bash "$HOME/dotfiles/setup/setup.sh"
