#!/usr/bin/env bash

# Change shell to fish.
fish_path="$(which fish)"
if [ -n "$fish_path" ]; then
	if ! grep -Fxq "$fish_path" /etc/shells; then
		echo "$fish_path" | sudo tee -a /etc/shells > /dev/null
	fi
	if [ "$SHELL" != "$fish_path" ]; then
		chsh -s "$fish_path"
	fi
fi
