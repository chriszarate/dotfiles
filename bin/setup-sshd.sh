#!/usr/bin/env bash

# Disable password-based SSH login after public-key login has been tested.
# This is deliberately separate from setup.sh because a mistake can lock a
# remote user out of the machine.

set -euo pipefail

if [ "$(uname)" != "Darwin" ]; then
	echo "This command currently supports macOS only." >&2
	exit 1
fi

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="$DOTFILES/ssh/10-key-only.conf"
target_file="/etc/ssh/sshd_config.d/10-key-only.conf"
sshd_bin="/usr/sbin/sshd"

if [ ! -x "$sshd_bin" ]; then
	echo "sshd was not found at $sshd_bin." >&2
	exit 1
fi

	replace_legacy_link=false
if sudo test -e "$target_file" || sudo test -L "$target_file"; then
	if ! sudo cmp -s "$source_file" "$target_file"; then
		echo "Refusing to overwrite the existing $target_file." >&2
		echo "Review or remove it by hand, then run this command again." >&2
		exit 1
	fi

	if ! sudo test -L "$target_file"; then
		sudo "$sshd_bin" -t
		echo "✅ SSH already requires public-key login."
		exit 0
	fi

	# Older versions of setup-links.sh created this symlink. Its contents are
	# known to match, so it is safe to replace after the checks below.
	replace_legacy_link=true
fi

cat <<'EOF'
This will disable SSH password and keyboard-interactive login.

Before continuing, open a second terminal and confirm that you can connect to
this Mac using your SSH key. Keep the existing session open until a new login
succeeds.
EOF

read -r -p "Have you successfully tested public-key login? [y/N] " answer
case "$answer" in
	y | Y | yes | YES) ;;
	*)
		echo "No changes made."
		exit 0
		;;
esac

# Check the proposed file before installing it. sshd needs root access to read
# the system host keys during validation.
sudo "$sshd_bin" -t -f "$source_file"
sudo mkdir -p "$(dirname "$target_file")"
if [ "$replace_legacy_link" = true ]; then
	sudo "$sshd_bin" -t
	sudo rm "$target_file"
fi
sudo install -o root -g wheel -m 0644 "$source_file" "$target_file"

# Validate the complete system configuration. Remove only the file this command
# just created if the combined configuration is invalid.
if ! sudo "$sshd_bin" -t; then
	sudo rm "$target_file"
	echo "The combined SSH configuration was invalid; the new file was removed." >&2
	exit 1
fi

echo "✅ SSH now requires public-key login."
