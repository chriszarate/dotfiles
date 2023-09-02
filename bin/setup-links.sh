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
	'.config/bat::bat'
	'.config/fish::fish'
	'.config/kitty::kitty'
	'.config/ranger::ranger'
	'.hammerspoon::hammerspoon'
	'.vim/coc-settings.json::vim/coc-settings.json'
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
	bash/bashrc \
	brew/Brewfile \
	editor/editorconfig \
	fd/fdignore \
	git/gitconfig \
	git/gitignore_global \
	input/inputrc \
	node/node-version \
	rg/rgignore \
	rg/rgignore-tests \
	rg/ripgreprc \
	vim/vimrc \
	zsh/zshrc
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
