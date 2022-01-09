#!/usr/bin/env bash

set -euxo pipefail

# Setup vim plugin manager.
if [ ! -f ~/.vim/autoload/plug.vim ]; then
	mkdir -p ~/.vim/autoload
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install and update plugins
vim +'PlugInstall --sync' +'PlugUpdate --sync' +qa
