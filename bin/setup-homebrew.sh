#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

# Install linuxbrew packages.
if [ "$(uname)" = "Linux" ]; then
  /home/linuxbrew/.linuxbrew/bin/brew bundle --file="$DOTFILES/brew/Brewfile-linux"
fi

# Install brew packages and casks
if [ "$(uname)" = "Darwin" ]; then
  brew bundle --file="$DOTFILES/brew/Brewfile"
fi
