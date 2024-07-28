function fish_right_prompt -d 'Decorate the right prompt'
	set -l prompt_color '#a89984'
	set -l current_pwd (prompt_pwd)

	if test "$current_pwd" != "$last_known_pwd"
		set -g last_known_pwd "$current_pwd"
		printf '%s%s ' (set_color $prompt_color) $current_pwd
	end
end
