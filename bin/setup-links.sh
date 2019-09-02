#!/usr/bin/env bash

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"

# Symlink subdirectories.
links=(
  '.git_template::git/template'
)
for link in "${links[@]}"; do
  source="${link##*::}"
  target="${link%%::*}"
  if [ ! -e "$HOME/$target" ]; then
    ln -s "$DOTFILES/$source" "$HOME/$target"
  fi
done

# Symlink dotfiles in subdirectories.
links=(
  '.config/alacritty::alacritty/alacritty.yml'
  '.config/fish::fish/completions'
  '.config/fish::fish/config.fish'
  '.config/fish::fish/functions'
  '.config/fish::fish/inc'
  '.config/wtf::wtf/config.yml'
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
  ctags/ctags \
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
