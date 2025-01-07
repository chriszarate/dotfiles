#!/usr/bin/env bash

set -euxo pipefail

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES" || return

# Hush login message
touch "$HOME/.hushlogin"

# Create some placeholder directories.
for config_dir in \
	bin \
	config \
	config/fzf \
	config/vim
do
	mkdir -p "$HOME/.$config_dir"
done

# Symlink custom-location dotfiles.
links=(
	'.config/bat::bat'
	'.config/fish::fish'
	'.config/kitty::kitty'
	'.config/coc/coc-settings.json::vim/coc-settings.json'
	'.config/nvim/init.lua::nvim/init.lua'
	'.config/vim/vimrc::vim/vimrc'
	'.config/yazi::yazi'
	'.hammerspoon::hammerspoon'
)
for link in "${links[@]}"; do
	source="${link##*::}"
	target="${link%%::*}"

	if [ -f "$DOTFILES/$source" ]; then
		mkdir -p "$(dirname "$HOME/$target")"
	fi

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
	rg/rgignore \
	rg/rgignore-tests \
	rg/ripgreprc \
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
