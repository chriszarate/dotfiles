#!/usr/bin/env bash
#
# Stop a launchd agent and delete its installed plist from
# ~/Library/LaunchAgents. The source file in launchd/ is not touched.

set -euo pipefail

if [ $# -ne 1 ]; then
	echo "usage: $0 <label | path/to/label.plist>" >&2
	exit 2
fi

# Accept the same argument as bin/launchd-create.sh. Only the file name
# matters here, because the agent is found by its label.
label="$(basename "$1" .plist)"
target="$HOME/Library/LaunchAgents/$label.plist"
domain="gui/$(id -u)"

if [ ! -f "$target" ]; then
	echo "❌ Not installed: $target" >&2
	exit 1
fi

if launchctl print "$domain/$label" >/dev/null 2>&1; then
	launchctl bootout "$domain/$label"
fi

rm "$target"

# The symlink that bin/launchd-create.sh made to name the agent in System
# Settings. Not every agent has one.
rm -rf "$HOME/Library/Application Support/launchd-agents/$label"

# Clear a disabled flag left by bin/launchd-disable.sh, so no record of the
# agent stays in the launchd database.
launchctl enable "$domain/$label"

echo "✅ $label stopped and removed."
