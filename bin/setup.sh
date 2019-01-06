#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

DOTFILES=$DOTFILES $DOTFILES/bin/setup-apt.sh
DOTFILES=$DOTFILES $DOTFILES/bin/setup-homebrew.sh
DOTFILES=$DOTFILES $DOTFILES/bin/setup-links.sh

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

# Install Atom packages.
if [ -n "$(which apm)" ]; then
  apm_prefix="$HOME/.atom/packages"
  while read -r pkg; do
    if [ ! -d "$apm_prefix/$pkg" ]; then
      apm install "$pkg"
    fi
  done <"$DOTFILES/atom/packages.txt"
fi

# Install tmux plugin manager.
if [ ! -d ~/.tmux/plugins/tpm ]; then
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
