function fish_title -d 'Set the title for the current terminal window'

	set -l command "$_"

  switch "$command"

		# Prepend the command name to the directory basename for some commands.
		case bash fish git npm ranger sh tmux vi vim zsh
			printf '%s %s' "$command" (git_prompt_pwd)

		# Ignore some commands.
		case cd kitty ls pwd sleep

		# Otherwise just output the command name.
		case '*'
			echo "$command"

	end
end
