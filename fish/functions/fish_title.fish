function fish_title -d 'Set the title for the current terminal window'

	set -l command "$_"

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
end
