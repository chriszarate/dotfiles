#!/bin/sh

# Relative to home directory.
dotfiles=".dotfiles"

# Install brew packages
if [ "$(uname)" = "Darwin" ]; then
  while read pkg; do
    command -v $pkg >/dev/null 2>&1 || brew install $pkg
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

# Symlink fish config.
for config in \
  /fish/config.fish \
  /fish/functions \
  /fish/inc
do
  if [ ! -e ~/.config$config ]; then
    ln -s ~/$dotfiles$config ~/.config$config
  fi
done

# Add additional symlinks.
for config in \
  /editor/editorconfig \
  /input/inputrc \
  /git/gitconfig \
  /git/gitignore_global \
  /jshint/jshintrc \
  /jshint/jscsrc \
  /tmux/tmux.conf \
  /vim/vimrc
do
  if [ ! -e ~/.$(basename $config) ]; then
    ln -s $dotfiles$config ~/.$(basename $config)
  fi
done
