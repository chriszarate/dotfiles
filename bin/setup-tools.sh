#!/usr/bin/env bash

set -euo pipefail

# Guards use `command -v` rather than `which`, because `set -e` aborts the
# script on the failing assignment before an `if [ -n "$var" ]` check below it
# ever runs. That made these blocks unreachable on any machine missing the
# tool — including Linux, where setup-homebrew.sh installs nothing.

# Install default node
if command -v fnm >/dev/null; then
	fnm install 24
	fnm default 24
fi

# Install cargo tools. Homebrew's rustup is keg-only, so its shims may not be
# on $PATH yet in this non-interactive shell; call it by its full path.
RUSTUP_BIN="$(command -v rustup || echo /opt/homebrew/opt/rustup/bin/rustup)"
if [ -x "$RUSTUP_BIN" ]; then
	mkdir -p ~/.cargo
	# `--force` because an old toolchain can still track a component Rust has since
	# dropped (rls-preview is the usual one), and rustup otherwise refuses to update
	# until it is removed by hand. Forcing skips the dead component and rewrites the
	# toolchain without it, so this only has to happen once per machine.
	"$RUSTUP_BIN" toolchain install --force stable
	"$RUSTUP_BIN" default stable
fi

# Install SilverBullet, which launchd/org.zzz.silverbullet.plist runs to serve
# the notes folder. Homebrew has no formula for it, so fetch the release binary.
# It only installs once: `silverbullet upgrade` updates the binary in place.
if [ ! -x "$HOME/.local/bin/silverbullet" ]; then
	case "$(uname -s)-$(uname -m)" in
	Darwin-arm64) sb_asset="darwin-aarch64" ;;
	Darwin-x86_64) sb_asset="darwin-x86_64" ;;
	Linux-aarch64) sb_asset="linux-aarch64" ;;
	Linux-x86_64) sb_asset="linux-x86_64" ;;
	*) sb_asset="" ;;
	esac

	if [ -n "$sb_asset" ]; then
		sb_tmp="$(mktemp -d)"
		curl -L --fail --silent --show-error -o "$sb_tmp/sb.zip" \
			"https://github.com/silverbulletmd/silverbullet/releases/latest/download/silverbullet-server-$sb_asset.zip"
		mkdir -p "$HOME/.local/bin"
		unzip -o -q "$sb_tmp/sb.zip" silverbullet -d "$HOME/.local/bin"
		rm -rf "$sb_tmp"
	fi
fi
