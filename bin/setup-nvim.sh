#!/usr/bin/env bash

set -euxo pipefail

PACK_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

# Setup vim plugin manager.
if [ ! -d "$PACK_DIR" ]; then
	git clone --depth 1 "https://github.com/wbthomason/packer.nvim" "$PACK_DIR"
fi
