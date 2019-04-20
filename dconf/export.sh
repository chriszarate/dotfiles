#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

dconf dump / > "$DOTFILES/dconf/user.conf"
