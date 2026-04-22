#!/usr/bin/env bash

# Expects DOTFILES_ENV to be set (by setup.sh). Falls back to reading ~/.dotfiles-env.
if [ -z "$DOTFILES_ENV" ] && [ -f "$HOME/.dotfiles-env" ]; then
  DOTFILES_ENV=$(cat "$HOME/.dotfiles-env")
fi
if [ -z "$DOTFILES_ENV" ]; then
  echo "ERROR: DOTFILES_ENV not set. Run setup/setup.sh first." >&2
  return 1 2>/dev/null || exit 1
fi

# Portable equivalent of `ln -sfn`: replace target if it's a symlink (including
# symlinks-to-dirs), then create fresh link. Without this, `ln -sf src dst/`
# when dst is a symlink-to-dir FOLLOWS the symlink and creates the link INSIDE
# the pointed-to dir — which is how the stale `config/nvim/nvim` was born.
# GNU ln has -n and BSD ln has -h for this, but neither is portable; explicit
# rm before link is.
safe_link() {
  local src=$1 dst=$2
  [ -L "$dst" ] && rm -- "$dst"
  ln -sf "$src" "$dst"
}

# Link every dotfile (leading `.`) under a source dir into $HOME, overriding
# whatever was there before.
link_dotfiles() {
  local src_dir=$1 f name
  for f in "$src_dir"/.*; do
    name=$(basename -- "$f")
    { [ "$name" = "." ] || [ "$name" = ".." ]; } && continue
    [ -e "$f" ] || continue
    safe_link "$f" "$HOME/$name"
  done
}

echo -e "\nSymlinking dotfiles (env=$DOTFILES_ENV)..."

dir=$HOME/dotfiles

# Common home dotfiles
link_dotfiles "$dir/config/home"

# Env-specific home dotfiles (overlay; overrides common for same filenames)
if [ -d "$dir/machines/$DOTFILES_ENV" ]; then
  link_dotfiles "$dir/machines/$DOTFILES_ENV"
fi

# nvim
mkdir -p "$HOME/.config"
safe_link "$dir/config/nvim" "$HOME/.config/nvim"

# vim spell
mkdir -p "$HOME/.vim"
safe_link "$dir/config/.vim/spell" "$HOME/.vim/spell"

# ipython profile (per-file so user's profile_default/ can coexist)
mkdir -p "$HOME/.ipython/profile_default"
for f in "$dir"/config/.ipython/profile_default/*; do
  [ -e "$f" ] || continue
  safe_link "$f" "$HOME/.ipython/profile_default/$(basename -- "$f")"
done

# codex: generated from common + env fragments
mkdir -p "$HOME/.codex"
cat "$dir/config/codex/common.toml" \
    "$dir/machines/$DOTFILES_ENV/codex/env.toml" > "$HOME/.codex/config.toml"

# claude: env-specific settings.json; shared subdirs/CLAUDE.md if present
mkdir -p "$HOME/.claude"
safe_link "$dir/machines/$DOTFILES_ENV/claude/settings.json" "$HOME/.claude/settings.json"
for sub in agents commands skills output-styles; do
  if [ -d "$dir/config/claude/$sub" ]; then
    safe_link "$dir/config/claude/$sub" "$HOME/.claude/$sub"
  fi
done
if [ -f "$dir/config/claude/CLAUDE.md" ]; then
  safe_link "$dir/config/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
fi

# crontab (common)
if [ -f "$dir/config/home/crontab" ]; then
  crontab "$dir/config/home/crontab" 2>/dev/null || true
fi

# terminfo (italics-capable tmux entries)
tic -xo "$HOME/.terminfo" "$dir/config/tmux/xterm-256color-italic.terminfo" 2>/dev/null || true
tic -xo "$HOME/.terminfo" "$dir/config/tmux/tmux-256color.terminfo" 2>/dev/null || true

echo "Symlinking done."
