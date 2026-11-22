#!/usr/bin/env bash
#
# Stop a launchd agent and delete its installed plist from
# ~/Library/LaunchAgents. The source file in launchd/ is not touched.

set -euo pipefail

if [ $# -ne 1 ]; then
	echo "usage: $0 <label>" >&2
	exit 2
fi

label="${1%.plist}"
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

# Clear a disabled flag left by bin/launchd-disable.sh, so no record of the
# agent stays in the launchd database.
launchctl enable "$domain/$label"

echo "✅ $label stopped and removed."
