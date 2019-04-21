#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

# Install linuxbrew packages.
if [ "$(uname)" = "Linux" ]; then
  if ! command -v brew >/dev/null; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  fi

  /home/linuxbrew/.linuxbrew/bin/brew bundle --file="$DOTFILES/brew/Brewfile-linux"
fi

# Install brew packages and casks
if [ "$(uname)" = "Darwin" ]; then
  if ! command -v brew >/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew bundle --file="$DOTFILES/brew/Brewfile"
fi
