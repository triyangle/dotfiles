#!/usr/bin/env bash
echo -e "Initiliazing vim setup..."

echo -e "\nRetrieving vim-plug from GitHub..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\nInstalling nvim plugins..."
nvim +"PlugInstall YouCompleteMe" +PlugInstall +qall

# pynvim for neovim's Python plugin support. On Ubuntu/Ona it comes via apt
# as python3-pynvim (transitive dep of neovim). Fall back to pip only if the
# module isn't already importable.
if ! python3 -c 'import pynvim' >/dev/null 2>&1; then
  if command -v pip3 >/dev/null 2>&1; then
    pip3 install --user --break-system-packages pynvim 2>/dev/null \
      || pip3 install --user pynvim 2>/dev/null \
      || true
  elif command -v pip >/dev/null 2>&1; then
    pip install --user pynvim 2>/dev/null || true
  fi
fi

echo ""
