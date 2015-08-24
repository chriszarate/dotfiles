#!/bin/sh

# Relative to home directory.
dotfiles=".dotfiles"

# Install brew packages
if [ "$(uname)" = "Darwin" ]; then
  cellar=`brew --cellar`
  while read pkg; do
    if [ ! -d $cellar/$pkg ]; then
      brew install $pkg
    fi
  done <~/$dotfiles/brew/packages.txt
fi

# Install global npm packages
if [ -n "$(which npm)" ]; then
  npm_prefix=`npm config get prefix`
  while read pkg; do
    if [ ! -d $npm_prefix/lib/node_modules/$pkg ]; then
      npm -g install $pkg
    fi
  done <~/$dotfiles/npm/packages.txt
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

# Symlink nested dotfiles.
for config in \
  vim/colors
do
  mkdir -p ~/.$(dirname $config)
  if [ ! -e ~/.$config ]; then
    ln -s ~/$dotfiles/$config ~/.$config
  fi
done

# Symlink dotfiles.
for config in \
  editor/editorconfig \
  input/inputrc \
  git/gitconfig \
  git/gitignore_global \
  lint/jshintrc \
  lint/jscsrc \
  tmux/tmux.conf \
  vim/vimrc
do
  if [ ! -e ~/.$(basename $config) ]; then
    ln -s $dotfiles/$config ~/.$(basename $config)
  fi
done

# Install tmux plugin manager.
if [ ! -d ~/.tmux/plugins/tpm ]; then
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Download and symlink PHP phars.
pharchive=~/.phar
mkdir -p $pharchive
while read phar_url; do
  phar_name=$(basename $phar_url)
  if [ ! -f $pharchive/$phar_name ]; then
    curl -o $pharchive/$phar_name $phar_url
    chmod +x $pharchive/$phar_name
    ln -s $pharchive/$phar_name /usr/local/bin/$(echo $phar_name | rev | cut -c 6- | rev)
  fi
done <~/$dotfiles/php/phars.txt
