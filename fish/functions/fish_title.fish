function fish_title -d 'Set the title for the current terminal window'

	set -l command "$_"

	# Alias some commands.
	switch "$command"

		case br
			set command "broot"

	end

  switch "$command"

    # If we're SSHing, attempt to extract the hostname.
		case ssh
			printf 'ssh %s' (echo "$argv[1]" | awk '{ for(i=NF; i>0; i--) { if(match($i, /^[^\-]/)) {print $i; break} } }')

		# Prepend the command name to the directory basename for some commands.
		case bash broot fish git nano npm pico sh tmux vi vim zsh
			printf '%s %s' "$command" (git_prompt_pwd)

		# Ignore some commands.
		case cd kitty ls sleep

		# Otherwise just output the command name.
		case '*'
			echo "$command"

	end

end
