#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

if [ "$(uname)" = "Linux" ]; then
	$DOTFILES/apt/install-repos.sh
	sudo apt -y install $(<"$DOTFILES/apt/packages.txt")
fi
