#!/usr/bin/env bash

set -euo pipefail

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES" || return

# Hush login message
touch "$HOME/.hushlogin"

# Create some placeholder directories.
for config_dir in \
	bin \
	config \
	config/fzf \
	config/gh \
	config/nvim; do
	mkdir -p "$HOME/.$config_dir"
done

# Create one symlink, unless something is already in the way.
#
# Skipping quietly was hiding real problems: on a machine that already had a
# ~/.gitconfig, setup finished "successfully" having linked nothing. Report all
# conflicts in one run, then fail after checking every link.
link_failures=0
link() {
	local source="$1"
	local target="$2"
	local sudo_cmd="${3:-}"

	if [ -L "$target" ]; then
		if [ "$(readlink "$target")" = "$source" ]; then
			return 0
		fi
		echo "⚠️  $target is a symlink to somewhere else; leaving it alone." >&2
		echo "   Wanted: $source" >&2
		echo "   Found:  $(readlink "$target")" >&2
		link_failures=$((link_failures + 1))
		return 0
	fi

	if [ -e "$target" ]; then
		echo "⚠️  $target already exists and is not a symlink; leaving it alone." >&2
		echo "   Move it aside and re-run to link $source." >&2
		link_failures=$((link_failures + 1))
		return 0
	fi

	$sudo_cmd mkdir -p "$(dirname "$target")"
	$sudo_cmd ln -s "$source" "$target"
}

# Keep the selected theme machine-local, but provide a working default on a
# fresh checkout. An existing file or link represents an intentional choice.
kitty_theme="$DOTFILES/kitty/current-theme.conf"
if [ ! -e "$kitty_theme" ] && [ ! -L "$kitty_theme" ]; then
	ln -s "$DOTFILES/kitty/themes/gruvbox-darker.conf" "$kitty_theme"
fi

# Symlink custom-location dotfiles.
links=(
	'.claude/CLAUDE.md::agents/AGENTS.md'
	'.claude/settings.json::agents/claude/settings.json'
	'.codex/AGENTS.md::agents/AGENTS.md'
	'.config/bat::bat'
	'.config/fish::fish'
	'.config/gh/config.yml::gh/config.yml'
	'.config/herdr/config.toml::herdr/config.toml'
	'.config/kitty::kitty'
	'.config/nvim/init.lua::nvim/init.lua'
	'.config/nvim/lazy-lock.json::nvim/lazy-lock.json'
	'.config/nvim/lua::nvim/lua'
	'.config/worktrunk::worktrunk'
	'.config/yazi::yazi'
	'.hammerspoon::hammerspoon'
	'.ssh/git_allowed_signers::git/allowed_signers'
)
for entry in "${links[@]}"; do
	link "$DOTFILES/${entry##*::}" "$HOME/${entry%%::*}"
done

# Symlink dotfiles.
for config in \
	bash/bashrc \
	brew/Brewfile \
	editor/editorconfig \
	fd/fdignore \
	git/gitconfig \
	git/gitignore_global \
	input/inputrc \
	rg/rgignore \
	rg/rgignore-tests \
	rg/ripgreprc \
	zsh/zshrc; do
	link "$DOTFILES/$config" "$HOME/.$(basename "$config")"
done

# Symlink helpers.
for helper in "$DOTFILES/bin/helpers"/*; do
	link "$helper" "$HOME/.bin/$(basename "$helper")"
done

# Symlink the system file that requires sudo.
#
# sudo_local enables TouchID for sudo. macOS includes it from /etc/pam.d/sudo
# and leaves it alone across system updates, which /etc/pam.d/sudo itself is
# not — so this replaces the manual edit that used to need redoing.
if [ "$(uname)" = "Darwin" ]; then
	link "$DOTFILES/pam/sudo_local" "/etc/pam.d/sudo_local" sudo
fi

if [ "$link_failures" -gt 0 ]; then
	echo "❌ $link_failures link conflict(s) left setup incomplete." >&2
	exit 1
fi
