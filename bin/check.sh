#!/usr/bin/env bash
#
# Lint everything in this repository. Run it by hand before committing.
#
# These are syntax checks, not style checks. Every file here is hand-written
# and deliberately formatted, so the job is catching a typo that would break a
# shell or an editor at startup — not enforcing a house style.
#
# Each linter is optional: a machine that has not run bin/setup.sh yet should
# still be able to run this and get useful output for the tools it does have.

set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$DOTFILES" || exit 1

fail=0

report() {
	if [ "$1" -eq 0 ]; then
		printf '✅ %s\n' "$2"
	else
		printf '❌ %s\n' "$2"
		fail=1
	fi
}

skip() { printf '⏭️  %s (not installed)\n' "$1"; }

# Shell scripts. The helpers have no extension, so they are listed explicitly
# rather than found by glob.
if command -v shellcheck > /dev/null; then
	shellcheck bin/*.sh bin/helpers/*
	report $? "shellcheck"
else
	skip "shellcheck"
fi

# fish -n parses without executing, so a broken function is caught here rather
# than at the next shell start.
if command -v fish > /dev/null; then
	fish_status=0
	for f in fish/config.fish fish/conf.d/*.fish fish/functions/*.fish; do
		fish -n "$f" || fish_status=1
	done
	report "$fish_status" "fish syntax"
else
	skip "fish"
fi

# luac -p is the Lua equivalent: compile and discard, reporting syntax errors.
# A broken file here means nvim, yazi, or Hammerspoon fails to start.
if command -v luac > /dev/null; then
	lua_status=0
	while IFS= read -r f; do
		luac -p "$f" || lua_status=1
	done < <(find hammerspoon nvim yazi -name '*.lua' -not -path '*/Spoons/*')
	report "$lua_status" "lua syntax"
else
	skip "luac"
fi

# Relaxed, because gh writes this file itself and its comment lines run long.
if command -v yamllint > /dev/null; then
	yamllint -d relaxed --no-warnings gh/config.yml
	report $? "yamllint"
else
	skip "yamllint"
fi

# JSON files are hand-edited and easy to leave with a trailing comma.
if command -v jq > /dev/null; then
	json_status=0
	for f in agents/claude/settings.json herdr/plugins.json nvim/lazy-lock.json; do
		[ -f "$f" ] || continue
		jq -e . "$f" > /dev/null || { echo "invalid JSON: $f"; json_status=1; }
	done
	report "$json_status" "json syntax"
else
	skip "jq"
fi

# Secret scanning. --redact keeps anything it finds out of the terminal and
# the scrollback; --verbose names the file, line, and rule so a hit is
# actionable.
if command -v gitleaks > /dev/null; then
	gitleaks dir . --no-banner --redact --verbose --log-level warn
	report $? "gitleaks"
else
	skip "gitleaks"
fi

# The Brewfile drifts quietly: a formula installed by hand never lands here,
# and `brewdump` only notices after the fact. A warning, not a failure — drift
# is worth knowing about but should not block an unrelated commit.
if command -v brew > /dev/null; then
	if HOMEBREW_BUNDLE_FILE="$DOTFILES/brew/Brewfile" \
		HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check > /dev/null 2>&1; then
		report 0 "Brewfile"
	else
		printf '⚠️  Brewfile: installed packages differ (run brew bundle install)\n'
	fi
else
	skip "brew"
fi

exit "$fail"
