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
	"$RUSTUP_BIN" toolchain install stable
	"$RUSTUP_BIN" default stable
fi
