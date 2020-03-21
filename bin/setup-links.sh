#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

# Symlink subdirectories.
links=(
  '.config/bat::bat'
  '.config/fish/completions::fish/completions'
  '.config/fish/config.fish::fish/config.fish'
  '.config/fish/functions::fish/functions'
  '.config/fish/inc::fish/inc'
  '.config/kitty::kitty'
  '.git_template::git/template'
  '.hammerspoon::hammerspoon'
  '.vim/UltiSnips::vim/UltiSnips'
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
  git/gitconfig \
  git/gitignore_global \
  tmux/tmux.conf \
  vim/vimrc
do
  if [ ! -e "$HOME/.$(basename "$config")" ]; then
    ln -s "$DOTFILES/$config" "$HOME/.$(basename "$config")"
  fi
done
