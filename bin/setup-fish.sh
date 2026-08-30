#!/usr/bin/env bash

set -euxo pipefail

# Change shell to fish. See setup-tools.sh for why this guard uses
# `command -v` rather than `which`.
if command -v fish > /dev/null; then
	fish_path="$(command -v fish)"

	if [ "$(basename "$SHELL")" != "fish" ]; then
		if ! grep -Fxq "$fish_path" /etc/shells; then
			echo "$fish_path" | sudo tee -a /etc/shells > /dev/null
		fi

		chsh -s "$fish_path"
	fi
fi
