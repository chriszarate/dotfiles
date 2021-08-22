#!/usr/bin/env bash

# Setup vim plugin manager.
if [ ! -f ~/.vim/autoload/plug.vim ]; then
	mkdir -p ~/.vim/autoload
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
