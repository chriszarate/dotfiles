#!/usr/bin/env bash

# Unlike the other setup scripts this one skips `set -x`. It moves a few GB
# over the network and prints its own progress; tracing every line would bury
# that under noise.
set -euo pipefail

# Relative to home directory.
DOTFILES="$HOME/.dotfiles"
MODELS_PRESET="$DOTFILES/agents/models.conf"
MODELS_DIR="${LLM_MODELS_DIR:-$HOME/Code/models}"

# Models to fetch, as "huggingface-repo|filename". The filename must match a
# `model =` line in models.conf, which is what actually points llama-server at
# the file. The check at the end of this script enforces that.
MODELS=(
	'unsloth/Qwen3.5-4B-GGUF|Qwen3.5-4B-UD-Q4_K_XL.gguf'
)

say() { printf '%s\n' "$*"; }
die() {
	printf '❌ %s\n' "$*" >&2
	exit 1
}

for tool in llama-server jq curl; do
	command -v "$tool" >/dev/null 2>&1 ||
		die "$tool not found. Run bin/setup-homebrew.sh first."
done

say "Models directory: $MODELS_DIR"
mkdir -p "$MODELS_DIR"

# Ask Hugging Face how big the file should be. Downloads get interrupted, and
# a half-written GGUF looks fine to `test -f` but makes llama-server exit 1 —
# which is exactly the failure this script exists to prevent.
remote_size() {
	curl -sIL "$1" |
		grep -i '^content-length:' |
		tail -n 1 |
		tr -d '\r' |
		awk '{print $2}'
}

local_size() {
	if [ -f "$1" ]; then
		stat -f%z "$1" 2>/dev/null || stat -c%s "$1" 2>/dev/null || echo 0
	else
		echo 0
	fi
}

for entry in "${MODELS[@]}"; do
	repo="${entry%%|*}"
	file="${entry##*|}"
	dest="$MODELS_DIR/$file"
	part="$dest.part"
	url="https://huggingface.co/$repo/resolve/main/$file"

	expected="$(remote_size "$url" || true)"
	if [ -z "$expected" ]; then
		say "⚠️  Could not reach Hugging Face for $file; skipping size check."
		if [ -f "$dest" ]; then
			say "✅ $file already present."
			continue
		fi
		die "Cannot download $file without network access."
	fi

	if [ "$(local_size "$dest")" = "$expected" ]; then
		say "✅ $file already present and complete."
		continue
	fi

	if [ -f "$dest" ]; then
		say "♻️  $file is the wrong size; re-downloading."
		mv "$dest" "$part"
	fi

	# Download to a .part file so an interrupted run never leaves something
	# that looks complete. `-C -` resumes where a previous run stopped.
	say "⬇️  Downloading $file ($((expected / 1024 / 1024)) MB) from $repo..."
	curl -L --fail --progress-bar -C - -o "$part" "$url"

	[ "$(local_size "$part")" = "$expected" ] ||
		die "$file downloaded incompletely. Re-run this script to resume."

	mv "$part" "$dest"
	say "✅ $file downloaded."
done

# Every model the preset references must now exist, including any added to
# models.conf by hand without a matching entry in MODELS above.
missing=0
while IFS= read -r path; do
	case "$path" in
		/*) model_path="$path" ;;
		*) model_path="$MODELS_DIR/$path" ;;
	esac

	if [ ! -f "$model_path" ]; then
		say "❌ Referenced by models.conf but missing: $model_path"
		missing=1
	fi
done < <(
	grep -E '^[[:space:]]*model[[:space:]]*=' "$MODELS_PRESET" |
		sed -E 's/^[[:space:]]*model[[:space:]]*=[[:space:]]*//'
)

[ "$missing" -eq 0 ] || die "Add the missing models to the MODELS list in $0."

say "🎉 Local LLM ready. Press ctrl-e in fish to turn a prompt into a command."
say "   Start the server now with: llm_server"
