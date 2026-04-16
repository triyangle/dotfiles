#!/usr/bin/env bash

# Expects DOTFILES_ENV to be set (by setup.sh). Falls back to reading ~/.dotfiles-env.
if [ -z "$DOTFILES_ENV" ] && [ -f "$HOME/.dotfiles-env" ]; then
  DOTFILES_ENV=$(cat "$HOME/.dotfiles-env")
fi
if [ -z "$DOTFILES_ENV" ]; then
  echo "ERROR: DOTFILES_ENV not set. Run setup/setup.sh first." >&2
  return 1 2>/dev/null || exit 1
fi

echo -e "\nSymlinking dotfiles (env=$DOTFILES_ENV)..."

dir=~/dotfiles

# Common home dotfiles
ln -sf "$dir"/config/home/.* ~/

# Env-specific home dotfiles (overlay; overrides common for same filenames)
if [ -d "$dir/machines/$DOTFILES_ENV" ]; then
  for f in "$dir/machines/$DOTFILES_ENV"/.*; do
    name=$(basename "$f")
    { [ "$name" = "." ] || [ "$name" = ".." ]; } && continue
    [ -e "$f" ] || continue
    ln -sf "$f" ~/
  done
fi

# nvim
mkdir -p ~/.config
ln -sf "$dir/config/nvim" ~/.config/nvim

# vim spell
mkdir -p ~/.vim
ln -sf "$dir/config/.vim/spell" ~/.vim/

# ipython profile
mkdir -p ~/.ipython/profile_default
ln -sf "$dir"/config/.ipython/profile_default/* ~/.ipython/profile_default/

# codex: generated from common + env fragments
mkdir -p ~/.codex
cat "$dir/config/codex/common.toml" \
    "$dir/machines/$DOTFILES_ENV/codex/env.toml" > ~/.codex/config.toml

# claude: env-specific settings.json; shared subdirs/CLAUDE.md if present
mkdir -p ~/.claude
ln -sf "$dir/machines/$DOTFILES_ENV/claude/settings.json" ~/.claude/settings.json
for sub in agents commands skills output-styles; do
  if [ -d "$dir/config/claude/$sub" ]; then
    ln -sf "$dir/config/claude/$sub" ~/.claude/"$sub"
  fi
done
if [ -f "$dir/config/claude/CLAUDE.md" ]; then
  ln -sf "$dir/config/claude/CLAUDE.md" ~/.claude/CLAUDE.md
fi

# crontab (common)
if [ -f "$dir/config/home/crontab" ]; then
  crontab "$dir/config/home/crontab" 2>/dev/null || true
fi

# terminfo (italics-capable tmux entries)
tic -xo ~/.terminfo "$dir/config/tmux/xterm-256color-italic.terminfo" 2>/dev/null || true
tic -xo ~/.terminfo "$dir/config/tmux/tmux-256color.terminfo" 2>/dev/null || true

echo "Symlinking done."
