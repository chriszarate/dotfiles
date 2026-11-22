#!/usr/bin/env bash
#
# Install a launchd agent from launchd/<label>.plist and start it. The
# argument can also be the path of a plist in another repository, so that a
# project keeps its own agent files and this script installs them.
#
# Safe to re-run: an agent that is already loaded is stopped and loaded again,
# so this is also how to apply an edit to the plist. It also re-enables an
# agent that bin/launchd-disable.sh turned off.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ $# -ne 1 ]; then
	echo "usage: $0 <label | path/to/label.plist>" >&2
	echo "available agents:" >&2
	for plist in "$DOTFILES/launchd"/*.plist; do
		[ -e "$plist" ] || continue
		echo "  $(basename "$plist" .plist)" >&2
	done
	exit 2
fi

# An argument with a slash is the path of a plist. Any other argument is a
# label in launchd/.
case "$1" in
*/*)
	source="$1"
	label="$(basename "$source" .plist)"
	;;
*)
	label="${1%.plist}"
	source="$DOTFILES/launchd/$label.plist"
	;;
esac
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

# System Settings lists an agent under the file name of its program, so an
# agent that runs through a shell shows up as "sh". Run the shell through a
# symlink named after the last part of the label instead: org.zzz.llama-server
# shows up as "llama-server". Only shells get this treatment. Another program
# can depend on its own path.
program="$(plutil -extract ProgramArguments.0 raw "$target" 2>/dev/null || true)"
case "$program" in
/bin/sh | /bin/bash | /bin/zsh)
	name_dir="$HOME/Library/Application Support/launchd-agents/$label"
	mkdir -p "$name_dir"
	ln -sf "$program" "$name_dir/${label##*.}"
	# plutil -replace on an array index inserts a new entry and keeps the
	# old one, so remove the old entry first.
	plutil -remove ProgramArguments.0 "$target"
	plutil -insert ProgramArguments.0 -string "$name_dir/${label##*.}" "$target"
	;;
esac

launchctl enable "$domain/$label"
launchctl bootstrap "$domain" "$target"

echo "✅ $label installed and loaded."
