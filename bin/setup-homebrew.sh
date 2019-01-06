#!/usr/bin/env bash

# Install linuxbrew packages.
if [ "$(uname)" = "Linux" ]; then
  PACKAGES=`cat $DOTFILES/brew/packages-linux.txt`
  /home/linuxbrew/.linuxbrew/bin/brew install $PACKAGES
fi

# Install brew packages and casks
if [ "$(uname)" = "Darwin" ]; then
  PACKAGES=`cat $DOTFILES/brew/packages.txt`
  CASKS=`cat $DOTFILES/brew/casks.txt`

  brew install $PACKAGES
  brew cask install $CASKS
fi
