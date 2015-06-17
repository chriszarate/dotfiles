#!/bin/sh

# Relative to home directory.
dotfiles=".dotfiles"

# Change shell to fish.
fish_path="$(which fish)"
if ! grep -Fxq "$fish_path" /etc/shells; then
  echo "$fish_path" | sudo tee -a /etc/shells > /dev/null
fi
chsh -s $fish_path

# Create symbolic links.
cd ~
ln -s $dotfiles/editor/editorconfig .editorconfig
ln -s $dotfiles/input/inputrc .inputrc
ln -s $dotfiles/git/gitconfig .gitconfig
ln -s $dotfiles/git/gitignore_global .gitignore_global
ln -s $dotfiles/jshint/jshintrc .jshintrc
ln -s $dotfiles/jshint/jscsrc .jscsrc
ln -s $dotfiles/tmux/tmux.conf .tmux.conf
ln -s $dotfiles/vim/vimrc .vimrc
