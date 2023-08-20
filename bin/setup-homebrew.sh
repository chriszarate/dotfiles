#!/usr/bin/env bash

set -euxo pipefail

# Install brew packages and casks
if [ "$(uname)" = "Darwin" ]; then
	if [ ! -f /opt/homebrew/bin/brew ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile" brew bundle install
fi
