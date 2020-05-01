#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

# Install brew packages and casks
if [ "$(uname)" = "Darwin" ]; then
  if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  brew bundle --file="$DOTFILES/brew/Brewfile"
fi
