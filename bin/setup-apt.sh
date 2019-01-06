#!/usr/bin/env bash

if [ "$(uname)" = "Linux" ]; then
  sudo apt -y install $(<"$DOTFILES/apt/packages.txt")
fi
