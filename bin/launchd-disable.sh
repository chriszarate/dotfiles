#!/usr/bin/env bash
#
# Stop a launchd agent and keep it from starting at the next login. The
# installed plist stays in ~/Library/LaunchAgents. Undo this with
# bin/launchd-create.sh.

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

# launchd keeps the disabled flag in its own database, so it survives a
# reboot.
launchctl disable "$domain/$label"

if launchctl print "$domain/$label" >/dev/null 2>&1; then
	launchctl bootout "$domain/$label"
fi

echo "✅ $label stopped and disabled."
