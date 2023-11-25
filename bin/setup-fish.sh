#!/usr/bin/env bash

set -euxo pipefail

# Change shell to fish.
fish_path="$(which fish)"
if [ -n "$fish_path" ] && [ "$(basename "$SHELL")" != "fish" ]; then
	if ! grep -Fxq "$fish_path" /etc/shells; then
		echo "$fish_path" | sudo tee -a /etc/shells > /dev/null
	fi

	chsh -s "$fish_path"
fi
