#!/bin/sh

# Relative to home directory.
dotfiles=".dotfiles"

# Install brew packages
if [ "$(uname)" = "Darwin" ]; then
  while read pkg; do
    brew install $pkg
  done <~/$dotfiles/brew/packages.txt
fi

# Change shell to fish.
fish_path="$(which fish)"
if ! grep -Fxq "$fish_path" /etc/shells; then
  echo "$fish_path" | sudo tee -a /etc/shells > /dev/null
fi
if [ "$SHELL" != "$fish_path" ]; then
  chsh -s $fish_path
fi

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
