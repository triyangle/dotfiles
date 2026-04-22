#!/usr/bin/env bash

echo -e "\nInitializing Ona/Codespaces setup..."

sudo apt-get update -y
sudo apt-get install -y neovim eza fzf cmake build-essential python3-dev

sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# Statsig CLI (siggy) — per the Vanta MCP/AI tools knowledge base card.
# Requires node/npm (present by default on Ona for the obsidian project).
# API keys still have to be pulled from 1Password manually:
#   siggy config -k <client key>
#   siggy config -c <console key>
if command -v npm >/dev/null 2>&1; then
  if ! command -v siggy >/dev/null 2>&1; then
    echo -e "\nInstalling Statsig siggy CLI..."
    npm install -g @statsig/siggy
  fi
fi

echo -e "\nDone"
