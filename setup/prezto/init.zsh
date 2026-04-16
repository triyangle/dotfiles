#!/usr/bin/env bash
ZPREZTO="${ZDOTDIR:-$HOME}/.zprezto"

for rcfile in "$ZPREZTO"/runcoms/*; do
  rcname=$(basename "$rcfile")
  [ "$rcname" = "README.md" ] && continue
  target="${ZDOTDIR:-$HOME}/.$rcname"

  if [ -f "$target" ] && [ ! -L "$target" ]; then
    # File exists and isn't a symlink — append sourcing (idempotent)
    if ! grep -q "zprezto/runcoms/$rcname" "$target" 2>/dev/null; then
      echo "source \"$ZPREZTO/runcoms/$rcname\"" >> "$target"
    fi
  else
    # No file or already a symlink — create/update symlink
    ln -sf "$rcfile" "$target"
  fi
done

# Ensure .zshrc.local is sourced
if ! grep -q 'zshrc.local' ~/.zshrc 2>/dev/null; then
  echo '[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local' >> ~/.zshrc
fi
