#!/usr/bin/env bash

set -euxo pipefail

# Install brew packages and casks
if [ "$(uname)" = "Darwin" ]; then
	BREW_BIN="/opt/homebrew/bin/brew"

	if [ ! -f "$BREW_BIN" ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	HOMEBREW_BUNDLE_FILE="$HOME/.dotfiles/brew/Brewfile" "$BREW_BIN" bundle install
fi
