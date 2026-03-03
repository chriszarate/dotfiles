function fish_title -d 'Set the title for the current terminal window'

	# Use the current command or the first argument, if passed.
	set -l command "$_"
	if test -n "$argv[1]"
		set command "$argv[1]"
	end

	# Extract the first token from the command.
	set -l command (string split ' ' -- $command)[1]

  switch "$command"

		# Some commands get detailed git information.
		case bash claude fish docker git npm npx nushell sh vi vim yazi yy zsh
			printf '%s %s' "$command" (git_prompt_pwd)

			set -l git_worktree (git_worktree)
			if test -n "$git_worktree"
				printf '/%s' "$git_worktree"
			end

			set -l git_branch (git_branch)
			if test -n "$git_branch"
				printf '#%s' "$git_branch"
			end

		# Ignore some commands.
		case cd kitty ls pwd sleep

		# Otherwise just output the command name.
		case '*'
			echo "$command"

	end

	# If a second argument is passed, consider it a file descriptor.
	if test -n "$argv[2]"
		printf ':%s' "$argv[2]"
	end
end
