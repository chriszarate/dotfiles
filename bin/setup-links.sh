#!/usr/bin/env bash

# Symlink dotfiles in subdirectories.
links=(
  '.config/fish::fish/completions'
  '.config/fish::fish/config.fish'
  '.config/fish::fish/functions'
  '.config/fish::fish/inc'
  '.atom::atom/config.cson'
  '.atom::atom/keymap.cson'
)
for link in "${links[@]}"; do
  source="${link##*::}"
  target="${link%%::*}"
  if [ ! -e "$HOME/$target/$(basename "$source")" ]; then
    mkdir -p "$HOME/$target"
    ln -s "$DOTFILES/$source" "$HOME/$target/$(basename "$source")"
  fi
done

# Symlink dotfiles.
for config in \
  input/inputrc \
  git/gitconfig \
  git/gitignore_global \
  tmux/tmux.conf \
  vim/vimrc
do
  if [ ! -e "$HOME/.$(basename "$config")" ]; then
    ln -s "$DOTFILES/$config" "$HOME/.$(basename "$config")"
  fi
done
