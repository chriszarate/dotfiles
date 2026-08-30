#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v git > /dev/null; then
	echo "git not found. Run bin/setup-homebrew.sh first." >&2
	exit 1
fi

if [ ! -d "$DOTFILES/.git" ]; then
	echo "$DOTFILES is not a Git checkout." >&2
	exit 1
fi

git -C "$DOTFILES" submodule sync --recursive

# The submodules are public. Use HTTPS during bootstrap so restoring GitHub SSH
# credentials is not a prerequisite for setting up Hammerspoon.
git -C "$DOTFILES" \
	-c 'url.https://github.com/.insteadOf=git@github.com:' \
	submodule update --init --recursive
