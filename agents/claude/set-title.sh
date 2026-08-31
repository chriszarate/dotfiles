#!/usr/bin/env bash
#
# CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1 (fish/conf.d/claude.fish) keeps claude
# itself from competing for the title.

input=$(cat)

# PostModelSwitch sends .to_model; SessionStart sends .model (not always).
model_id=$(printf '%s' "$input" | jq -r '.to_model // .model // empty')
if [ -z "$model_id" ]; then
	exit 0
fi

model_slug=${model_id#claude-}

# Stdout goes to claude, not the terminal, so write the OSC sequence for
# setting the title to /dev/tty (for non-Fish shells).
title=$(fish -c 'fish_title $argv' claude "$model_slug")
{ printf '\033]0;%s\a' "$title" >/dev/tty; } 2>/dev/null || true
