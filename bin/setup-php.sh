#!/usr/bin/env bash

# Relative to home directory.
dotfiles="$HOME/.dotfiles"

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

# Install global Composer dependencies.
composer global install --no-dev
composer_path="$HOME/.composer/vendor"
for pkg in $composer_path/bin/*; do
  pkg_name="$(basename "$pkg")"
  if [ ! -f "/usr/local/bin/$pkg_name" ]; then
    ln -s "$composer_path/bin/$pkg_name" "/usr/local/bin/$pkg_name"
  fi
done

# Set install paths for PHPCS.
for config in \
  wp-coding-standards/wpcs
do
  if [ -d "$composer_path/$config" ]; then
    phpcs --config-set installed_paths "$composer_path/$config"
  fi
done

