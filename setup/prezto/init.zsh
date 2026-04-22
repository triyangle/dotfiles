#!/usr/bin/env bash
# Always install each prezto runcom as a sourcing-stub at ~/.<name>, never a
# symlink. This way appends like the .zshrc.local line below never leak through
# to the prezto fork's runcoms/ directory, and the behavior is uniform whether
# or not a base image already ships a ~/.zshrc.

ZPREZTO="${ZDOTDIR:-$HOME}/.zprezto"

for rcfile in "$ZPREZTO"/runcoms/*; do
  rcname=$(basename "$rcfile")
  [ "$rcname" = "README.md" ] && continue
  target="${ZDOTDIR:-$HOME}/.$rcname"

  # Replace any legacy symlink from a previous install (tolerate rm failure)
  [ -L "$target" ] && rm -- "$target" 2>/dev/null

  # Create empty stub if missing; skip this runcom entirely if the target
  # can't be touched (e.g. Ona ships ~/.zshenv root-owned for secret
  # injection and the user can't overwrite it).
  if [ ! -f "$target" ]; then
    touch "$target" 2>/dev/null || continue
  fi
  [ -w "$target" ] || continue

  # Idempotent: only add source line once
  if ! grep -q "zprezto/runcoms/$rcname" "$target" 2>/dev/null; then
    echo "source \"$ZPREZTO/runcoms/$rcname\"" >> "$target"
  fi
done

# Ensure .zshrc.local is sourced (idempotent, writability-guarded)
if [ -w ~/.zshrc ] && ! grep -q 'zshrc.local' ~/.zshrc 2>/dev/null; then
  echo '[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local' >> ~/.zshrc
fi
