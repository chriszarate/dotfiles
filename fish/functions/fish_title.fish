function fish_title

  switch $_

    # If we're sitting a prompt, use the git origin or the working directory.
    case fish
      printf 'fish %s' (git_prompt_pwd)

    # If we're SSHing, attempt to extract the hostname.
		case ssh
			printf 'ssh %s' (echo "$argv[1]" | awk '{ for(i=NF; i>0; i--) { if(match($i, /^[^\-]/)) {print $i; break} } }')

		# Prepend the command name to the directory basename for some commands.
		case git nano npm pico tmux vi vim
			printf '%s %s' "$_" (git_prompt_pwd)

		# Ignore some commands.
		case cd kitty ls sleep

		# Otherwise just output the command name.
		case '*'
			echo "$_"

	end

end
