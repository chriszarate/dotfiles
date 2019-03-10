#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

if [ "$(uname)" = "Linux" ]; then
  sudo apt -y install $(<"$DOTFILES/apt/packages.txt")
fi
