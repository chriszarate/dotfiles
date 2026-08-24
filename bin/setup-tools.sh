#!/usr/bin/env bash

set -euxo pipefail

# Install default node
fnm_path="$(which fnm)"
if [ -n "$fnm_path" ]; then
	fnm install 24
	fnm default 24
fi

# Install cargo tools
rustup_path="$(which rustup)"
if [ -n "$rustup_path" ]; then
	mkdir ~/.cargo
	rustup install
	rustup toolchain install stable
fi
