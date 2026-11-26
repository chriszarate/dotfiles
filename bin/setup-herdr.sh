#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
registry="$HOME/.config/herdr/plugins.json"
legacy_registry="$DOTFILES/herdr/plugins.json"

# Plugins are "id|owner/repo/subdirectory|ref". The ID comes from the plugin's
# manifest and is used to recognize an existing installation.
plugins=(
	"persiyanov.reviewr|persiyanov/herdr-reviewr|main"
)

# Plugins I develop are "id|owner/repo". Each is cloned to ~/Code/repos/<repo>
# and linked rather than installed, so herdr runs it from the working copy.
linked_plugins=(
	"chriszarate.agent-usage|chriszarate/herdr-agent-usage"
)

for tool in git herdr jq; do
	if ! command -v "$tool" >/dev/null; then
		echo "$tool not found. Run bin/setup-homebrew.sh first." >&2
		exit 1
	fi
done

# Older setup versions linked generated plugin state into this repository.
# Remove only that known link; never replace an unrelated registry.
if [ -L "$registry" ] && [ "$(readlink "$registry")" = "$legacy_registry" ]; then
	rm "$registry"
fi

for plugin in "${plugins[@]}"; do
	plugin_id="${plugin%%|*}"
	remainder="${plugin#*|}"
	plugin_source="${remainder%%|*}"
	plugin_ref="${remainder##*|}"

	if [ -f "$registry" ] &&
		jq -e --arg id "$plugin_id" \
			'any(.[]; .plugin_id == $id)' "$registry" >/dev/null 2>&1; then
		echo "✅ $plugin_id already installed."
		continue
	fi

	herdr plugin install \
		"$plugin_source" \
		--ref "$plugin_ref" \
		--yes
done

for plugin in "${linked_plugins[@]}"; do
	plugin_id="${plugin%%|*}"
	plugin_repo="${plugin#*|}"
	plugin_dir="$HOME/Code/repos/${plugin_repo#*/}"

	if [ -f "$registry" ] &&
		jq -e --arg id "$plugin_id" \
			'any(.[]; .plugin_id == $id)' "$registry" >/dev/null 2>&1; then
		echo "✅ $plugin_id already linked."
		continue
	fi

	if [ ! -d "$plugin_dir" ]; then
		git clone "git@github.com:$plugin_repo.git" "$plugin_dir"
	fi

	herdr plugin link "$plugin_dir"
done
