#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
registry="$HOME/.config/herdr/plugins.json"
legacy_registry="$DOTFILES/herdr/plugins.json"

# Plugins are "id|owner/repo/subdirectory|ref". The ID comes from the plugin's
# manifest and is used to recognize an existing installation.
plugins=(
	'herdr-wakeup|usrivastava92/herdr-wakeup/plugin|v0.1.0'
)

for tool in herdr jq; do
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
