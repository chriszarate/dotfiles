function fish_title

	set -l command "$_"

	# Alias some commands.
	switch "$command"

		case br
			set command "broot"

	end

  switch "$command"

    # If we're sitting a prompt, use the git origin or the working directory.
    case fish
      printf 'fish %s' (git_prompt_pwd)

    # If we're SSHing, attempt to extract the hostname.
		case ssh
			printf 'ssh %s' (echo "$argv[1]" | awk '{ for(i=NF; i>0; i--) { if(match($i, /^[^\-]/)) {print $i; break} } }')

		# Prepend the command name to the directory basename for some commands.
		case broot git nano npm pico tmux vi vim
			printf '%s %s' "$command" (git_prompt_pwd)

		# Ignore some commands.
		case cd kitty ls sleep

		# Otherwise just output the command name.
		case '*'
			echo "$command"

	end

end
