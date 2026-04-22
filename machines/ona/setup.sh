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

# Register user-scope MCP servers via the supported Claude Code CLI.
# Idempotent: remove-then-add per server so re-running setup re-syncs to the
# dotfiles definition (picks up upstream changes). Env-var placeholders like
# '${DATADOG_API_KEY}' are written verbatim; Claude Code substitutes them at
# MCP launch time from the current shell env.
#
# claude mcp add syntax (per `claude mcp add --help`):
#   claude mcp add [options] <name> <commandOrUrl> [args...]
#   options include -s/--scope, -t/--transport, -e/--env, -H/--header
if command -v claude >/dev/null 2>&1; then
  echo -e "\nRegistering user-scope MCP servers..."
  _mcp_http() {
    local name=$1 url=$2
    claude mcp remove --scope user "$name" >/dev/null 2>&1 || true
    claude mcp add --scope user --transport http "$name" "$url" >/dev/null
  }
  _mcp_stdio() {
    local name=$1; shift
    claude mcp remove --scope user "$name" >/dev/null 2>&1 || true
    claude mcp add --scope user "$name" -- "$@" >/dev/null
  }
  _mcp_stdio_env() {
    # Args: <name> KEY=val [KEY=val ...] -- cmd [args...]
    # KEY=val pairs before -- become -e flags.
    local name=$1; shift
    local -a env_args=()
    while [ $# -gt 0 ] && [[ "$1" == *"="* ]]; do
      env_args+=(-e "$1"); shift
    done
    claude mcp remove --scope user "$name" >/dev/null 2>&1 || true
    claude mcp add --scope user "${env_args[@]}" "$name" -- "$@" >/dev/null
  }

  _mcp_http  figma               https://mcp.figma.com/mcp
  _mcp_http  glean_default       https://vanta-be.glean.com/mcp/default
  _mcp_http  context7            https://mcp.context7.com/mcp
  _mcp_stdio ESLint              npx @eslint/mcp@latest
  _mcp_stdio mcp-datetime        npx -y @odgrim/mcp-datetime
  _mcp_stdio unix_timestamps_mcp npx -y github:Ivor/unix-timestamps-mcp
  _mcp_stdio MongoDB             npx -y mongodb-mcp-server --connectionString 'mongodb://localhost:27017/?directConnection=true'
  _mcp_stdio datadog             npx datadog-mcp-server \
    --apiKey '${DATADOG_API_KEY}' --appKey '${DATADOG_APP_KEY}' \
    --site datadoghq.com --logsSite logs.datadoghq.com --metricsSite datadoghq.com
  _mcp_stdio_env datadog_logs \
    DD_API_KEY='${DATADOG_API_KEY}' DD_APP_KEY='${DATADOG_APP_KEY}' \
    npx -y @i524/datadog-mcp-server --stdio
fi

echo -e "\nDone"
