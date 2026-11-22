#!/usr/bin/env bash
#
# Install a launchd agent from launchd/<label>.plist and start it.
#
# Safe to re-run: an agent that is already loaded is stopped and loaded again,
# so this is also how to apply an edit to the plist. It also re-enables an
# agent that bin/launchd-disable.sh turned off.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ $# -ne 1 ]; then
	echo "usage: $0 <label>" >&2
	echo "available agents:" >&2
	for plist in "$DOTFILES/launchd"/*.plist; do
		[ -e "$plist" ] || continue
		echo "  $(basename "$plist" .plist)" >&2
	done
	exit 2
fi

label="${1%.plist}"
source="$DOTFILES/launchd/$label.plist"
target="$HOME/Library/LaunchAgents/$label.plist"
domain="gui/$(id -u)"

if [ ! -f "$source" ]; then
	echo "❌ No such agent file: $source" >&2
	exit 1
fi

plutil -lint -s "$source"

# launchctl addresses the agent by the Label inside the file. The other
# scripts assume the label and the file name are the same.
plist_label="$(plutil -extract Label raw "$source")"
if [ "$plist_label" != "$label" ]; then
	echo "❌ Label in $source is '$plist_label'; it must match the file name." >&2
	exit 1
fi

# Unload the old definition first. bootout returns before the agent is gone,
# and bootstrap fails while it is still there, so wait for it.
if launchctl print "$domain/$label" >/dev/null 2>&1; then
	launchctl bootout "$domain/$label" || true
	for _ in $(seq 50); do
		launchctl print "$domain/$label" >/dev/null 2>&1 || break
		sleep 0.2
	done
fi

# Copy rather than symlink, so the agent that runs at login is the one that
# was installed on purpose, not whatever the working tree holds that day.
mkdir -p "$HOME/Library/LaunchAgents"
install -m 644 "$source" "$target"

launchctl enable "$domain/$label"
launchctl bootstrap "$domain" "$target"

echo "✅ $label installed and loaded."
