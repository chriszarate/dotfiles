#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

$DOTFILES/bin/setup-apt.sh
$DOTFILES/bin/setup-homebrew.sh
$DOTFILES/bin/setup-links.sh

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

# Load dconf.
if [ "$(uname)" = "Linux" ]; then
	dconf load / < "$DOTFILES/dconf/user.conf"
fi

# Install tmux plugin manager.
if [ ! -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Setup vim plugin manager.
if [ ! -f ~/.vim/autoload/plug.vim ]; then
	mkdir -p ~/.vim/autoload
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

