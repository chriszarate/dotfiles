function fish_prompt
	printf '\n%s%s %s\n' (set_color 888888) (prompt_pwd) (__fish_git_prompt '%s')

	switch $fish_bind_mode
		case default
			set_color --bold 83a598

		case replace_one
			set_color --bold 8ec07c

		case visual
			set_color --bold fe8019

		case '*'
			set_color normal
	end

	echo '> '
end
