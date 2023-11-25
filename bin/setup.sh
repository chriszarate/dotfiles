#!/usr/bin/env bash

set -euxo pipefail

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

"$DOTFILES/bin/setup-homebrew.sh"
"$DOTFILES/bin/setup-links.sh"
"$DOTFILES/bin/setup-fish.sh"
"$DOTFILES/bin/setup-vim.sh"

if [ "$(uname)" = "Darwin" ]; then
	"$DOTFILES/bin/setup-osx.sh"
fi

glow "$DOTFILES/manual-tasks.md"
