#!/usr/bin/env bash

set -euxo pipefail

# Change shell to fish.
fish_path="$(which fish)"
if [ -n "$fish_path" ]; then
	if ! grep -Fxq "$fish_path" /etc/shells; then
		echo "$fish_path" | sudo tee -a /etc/shells > /dev/null
	fi
	if [ "$SHELL" != "$fish_path" ]; then
		chsh -s "$fish_path"
	fi

	fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin $HOME/.bin
fi
