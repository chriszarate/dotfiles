#!/usr/bin/env bash
#
# Make local servers reachable from the tailnet with `tailscale serve`.
#
# SERVES below is the whole serve configuration of this machine. The script
# resets the configuration and then applies each entry, so a serve that is
# not in the list is removed. Tailscale stores the result, and it survives a
# reboot. Run the script again after an edit to the list.
#
# setup.sh does not call this script, because it publishes local servers to
# every device on the tailnet. Run it by hand.

set -euo pipefail

# Each entry is "https-port|target". The server is then reachable at
# https://<machine>.<tailnet>.ts.net:<https-port>. Use the port of the local
# server, so that the port is the same on localhost and on the tailnet.
SERVES=(
	# Llama Server, started by launchd/org.zzz.llama-server.plist
	'4040|http://127.0.0.1:4040'
	# OpenTodo, started by launchd/org.zzz.opentodo.plist
	'1234|http://127.0.0.1:1234'
	# SilverBullet, started by launchd/org.zzz.silverbullet.plist
	'5678|http://127.0.0.1:5678'
)

# The Tailscale app does not put its command-line tool on $PATH.
TAILSCALE="$(command -v tailscale || echo /Applications/Tailscale.app/Contents/MacOS/Tailscale)"
if [ ! -x "$TAILSCALE" ]; then
	echo "❌ tailscale not found. Run bin/setup-homebrew.sh first." >&2
	exit 1
fi

status="$("$TAILSCALE" status --json)"

if [ "$(jq -r '.BackendState' <<<"$status")" != "Running" ]; then
	echo "❌ Tailscale is not connected. Log in and run this script again." >&2
	exit 1
fi

# Without HTTPS certificates, `tailscale serve` stops and waits for someone
# to turn them on in the admin console. Fail with the instruction instead.
if [ "$(jq -r '.CertDomains | length' <<<"$status")" -eq 0 ]; then
	echo "❌ HTTPS certificates are off for this tailnet." >&2
	echo "   Turn them on at https://login.tailscale.com/admin/dns" >&2
	echo "   (HTTPS Certificates > Enable HTTPS), then run this script again." >&2
	exit 1
fi

"$TAILSCALE" serve reset

for entry in "${SERVES[@]}"; do
	"$TAILSCALE" serve --bg --https="${entry%%|*}" "${entry#*|}"
done

"$TAILSCALE" serve status
