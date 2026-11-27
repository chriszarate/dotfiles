#!/usr/bin/env bash

set -euo pipefail

registry="${XDG_CONFIG_HOME:-$HOME/.config}/herdr/plugins.json"

for tool in git herdr jq; do
	if ! command -v "$tool" >/dev/null; then
		echo "$tool not found. Run bin/setup-homebrew.sh first." >&2
		exit 1
	fi
done

install_plugin() {
	local id="$1" repo="$2" registered
	if [ -f "$registry" ]; then
		registered=$(jq -r --arg id "$id" 'any(.[]; .plugin_id == $id)' "$registry")
		if [ "$registered" = true ]; then
			echo "$id is already registered."
			return 0
		fi
	fi

	herdr plugin install "$repo" --yes
}

# Add one entry per plugin: manifest ID, then GitHub owner/repo[/subdirectory].
install_plugin chriszarate.agent-usage chriszarate/herdr-agent-usage
