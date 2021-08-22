#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

$DOTFILES/bin/setup-homebrew.sh
$DOTFILES/bin/setup-links.sh
$DOTFILES/bin/setup-fish.sh
$DOTFILES/bin/setup-vim.sh
