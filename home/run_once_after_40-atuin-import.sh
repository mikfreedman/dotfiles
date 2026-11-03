#!/usr/bin/env bash
set -euo pipefail
log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# Copy existing zsh history into atuin's database, once per machine.
export PATH="/opt/homebrew/bin:$HOME/.local/share/mise/shims:$HOME/.local/bin:$PATH"
command -v atuin >/dev/null || exit 0
[[ -s "$HOME/.zsh_history" ]] || exit 0
log "Importing zsh history into atuin"
HISTFILE="$HOME/.zsh_history" atuin import zsh
