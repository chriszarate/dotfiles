function fish_title -d 'Set the title for the current terminal window'

	# Use the current command or the first argument, if passed.
	set -l command "$_"
	if test -n "$argv[1]"
		set command "$argv[1]"
	end

	# Extract the first token from the command.
	set -l command (string split ' ' -- $command)[1]

	set -l title ''

	switch "$command"

		# Some commands get detailed git information.
		case bash claude codex fish docker git npm npx nushell nvim sh vi vim yazi yy zsh
			set title "$command"

			# If a second argument is passed, consider it a command modifier.
			if test -n "$argv[2]"
				set title (printf '%s:%s' "$title" "$argv[2]")
			end

			set title (printf '%s %s' "$title" (git_prompt_pwd))

			set -l git_branch (git_branch)
			set -l git_worktree (git_worktree)

			# Show current worktree or branch, but not both.
			if test -n "$git_worktree"
				set title (printf '%s/%s' "$title" "$git_worktree")
			else if test -n "$git_branch"
				set title (printf '%s#%s' "$title" "$git_branch")
			end

			# If a third argument is passed, consider it a file descriptor.
			if test -n "$title" -a -n "$argv[3]"
				set title (printf '%s:%s' "$title" "$argv[3]")
			end

		# Ignore some commands.
		case cd kitty ls pwd sleep

		# Otherwise just output the command name.
		case '*'
			set title "$command"

	end

	# Inside Herdr, keep the tab label in sync with the title. Only send an
	# update when the title actually changes, and do it in the background so
	# the prompt never waits on the socket.
	if test -n "$title" -a -n "$HERDR_TAB_ID" -a "$title" != "$__herdr_tab_title"
		set -g __herdr_tab_title "$title"

		set -l herdr_bin $HERDR_BIN_PATH
		if test -z "$herdr_bin"
			set herdr_bin herdr
		end

		command $herdr_bin tab rename "$HERDR_TAB_ID" "$title" >/dev/null 2>&1 &
		disown 2>/dev/null
	end

	printf '%s' "$title"
end
