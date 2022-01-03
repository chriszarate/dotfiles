#!/usr/bin/env bash

set -euxo pipefail

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES" || return

# Create .config directory.
mkdir -p "$HOME/.config"

# Create .bin directory for local scripts.
mkdir -p "$HOME/.bin"

# Symlink custom-location dotfiles.
links=(
	'.config/coc/coc-settings.json::coc/coc-settings.json'
	'.config/fish::fish'
	'.config/kitty::kitty'
	'.hammerspoon::hammerspoon'
)
for link in "${links[@]}"; do
	source="${link##*::}"
	target="${link%%::*}"
	if [ ! -e "$HOME/$target" ]; then
		ln -s "$DOTFILES/$source" "$HOME/$target"
	fi
done

# Symlink dotfiles.
for config in \
	brew/Brewfile \
	editor/editorconfig \
	fd/fdignore \
	git/gitconfig \
	git/gitignore_global \
	input/inputrc \
	node/node-version \
	rg/rgignore \
	vim/vimrc
do
	if [ ! -e "$HOME/.$(basename "$config")" ]; then
		ln -s "$DOTFILES/$config" "$HOME/.$(basename "$config")"
	fi
done

# Symlink helpers.
for helper in "$DOTFILES/bin/helpers"/*; do
	if [ ! -e "$HOME/.bin/$(basename "$helper")" ]; then
		ln -s "$helper" "$HOME/.bin/$(basename "$helper")"
	fi
done
