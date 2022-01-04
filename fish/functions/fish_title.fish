function fish_title

  switch $_

    # If we're sitting a prompt, use the git origin or the working directory.
    case fish
      git_prompt_pwd

    # If we're SSHing, attempt to extract the hostname.
		case ssh
			printf 'ssh %s' (echo "$argv[1]" | awk '{ for(i=NF; i>0; i--) { if(match($i, /^[^\-]/)) {print $i; break} } }')

		# Ignore some commands.
		case cd
		case kitty
		case ls
		case sleep

		# Prepend the command name to the directory basename for some commands.
		case git
		case nano
		case npm
		case pico
		case tmux
		case vi
		case vim
			printf '%s %s' "$_" (git_prompt_pwd)

		# Otherwise just output the command name.
		case '*'
			echo "$_"

	end

end
