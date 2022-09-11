#!/usr/bin/env bash

set -euxo pipefail

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

"$DOTFILES/bin/setup-links.sh"
"$DOTFILES/bin/setup-homebrew.sh"
"$DOTFILES/bin/setup-fish.sh"
"$DOTFILES/bin/setup-nvim.sh"
"$DOTFILES/bin/setup-vim.sh"

glow "$DOTFILES/manual-tasks.md"
