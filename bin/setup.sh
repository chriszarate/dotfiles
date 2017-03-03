#!/usr/bin/env bash

# Relative to home directory.
dotfiles="$HOME/.dotfiles"

# Install brew packages and casks
if [ "$(uname)" = "Darwin" ]; then
  cellar="$(brew --cellar)"
  while read -r pkg; do
    if [ ! -d "$cellar/$(basename "$pkg")" ]; then
      brew install "$pkg"
    fi
  done <"$dotfiles/brew/packages.txt"
  caskroom="/opt/homebrew-cask/Caskroom/"
  while read -r cask; do
    if [ ! -d "$caskroom/$cask" ]; then
      brew cask install "$cask"
    fi
  done <"$dotfiles/brew/casks.txt"
fi

# Install global npm packages
if [ -n "$(which npm)" ]; then
  npm_prefix="$(npm config get prefix)"
  while read -r pkg; do
    if [ ! -d "$npm_prefix/lib/node_modules/$pkg" ]; then
      npm -g install "$pkg"
    fi
  done <"$dotfiles/npm/packages.txt"
fi

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

# Symlink dotfiles in subdirectories.
links=(
  '.config/fish::fish/config.fish'
  '.config/fish::fish/functions'
  '.config/fish::fish/inc'
  '.config/ranger::ranger/rc.conf'
  '.atom::atom/config.cson'
  '.atom::atom/keymap.cson'
  '.atom::atom/styles.less'
)
for link in "${links[@]}"; do
  source="${link##*::}"
  target="${link%%::*}"
  if [ ! -e "$HOME/$target/$(basename "$source")" ]; then
    mkdir -p "$HOME/$target"
    ln -s "$dotfiles/$source" "$HOME/$target/$(basename "$source")"
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
    ln -s "$dotfiles/$config" "$HOME/.$(basename "$config")"
  fi
done

# Install Atom packages.
if [ -n "$(which apm)" ]; then
  apm_prefix="$HOME/.atom/packages"
  while read -r pkg; do
    if [ ! -d "$apm_prefix/$pkg" ]; then
      apm install "$pkg"
    fi
  done <"$dotfiles/atom/packages.txt"
fi

# Install tmux plugin manager.
if [ ! -d ~/.tmux/plugins/tpm ]; then
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Download and symlink PHP phars.
pharchive=~/.phar
mkdir -p $pharchive
while read -r phar_url; do
  phar_name="$(basename "$phar_url")"
  if [ ! -f "$pharchive/$phar_name" ]; then
    curl -L -o "$pharchive/$phar_name" "$phar_url"
    chmod +x "$pharchive/$phar_name"
    ln -s "$pharchive/$phar_name" "/usr/local/bin/$(echo "$phar_name" | rev | cut -c 6- | rev)"
  fi
done <"$dotfiles/php/phars.txt"

while read -r ruleset; do
  ruleset_name="$(basename "$ruleset")"
  if [ ! -d "$pharchive/$ruleset_name" ]; then
    composer create-project "$ruleset:dev-master" --working-dir="$pharchive" --no-install --no-interaction
    phpcs --config-set installed_paths "$pharchive/$ruleset_name"
  fi
done <"$dotfiles/php/rulesets.txt"

