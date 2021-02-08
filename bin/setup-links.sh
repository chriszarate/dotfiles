#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

# Create .config directory.
mkdir -p "$HOME/.config/fish"

# Install / update submodules
cd "$DOTFILES" || return
git submodule update

# Symlink subdirectories.
links=(
	'.config/bat::bat'
	'.config/fish/completions::fish/completions'
	'.config/fish/config.fish::fish/config.fish'
	'.config/fish/functions::fish/functions'
	'.config/fish/inc::fish/inc'
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
	input/inputrc \
	fd/fdignore \
	git/gitconfig \
	git/gitignore_global \
	rg/rgignore \
	vim/vimrc
do
	if [ ! -e "$HOME/.$(basename "$config")" ]; then
		ln -s "$DOTFILES/$config" "$HOME/.$(basename "$config")"
	fi
done

# Symlink helpers.
sudo mkdir -p /usr/local/bin
for helper in "$DOTFILES/bin/helpers"/*; do
	if [ ! -e "/usr/local/bin/$(basename "$helper")" ]; then
		sudo ln -s "$helper" "/usr/local/bin/$(basename "$helper")"
	fi
done
