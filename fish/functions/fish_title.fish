function fish_title -d 'Set the title for the current terminal window'

	# Use the current command or the first argument, if passed.
	set -l command "$_"
	if test -n "$argv[1]"
		set command "$argv[1]"
	end

  switch "$command"

		# Prepend the command name to the directory basename for some commands.
		case dco docker docker-compose git npm ranger tmux vi vim yazi
			printf '%s %s' "$command" (git_prompt_pwd)

		# Shell prompts additionally get the git branch name
		case bash fish nushell sh zsh
			printf '%s %s %s' "$command" (git_prompt_pwd) (git_branch)

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
