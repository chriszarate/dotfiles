function fish_prompt
	printf '\n%s%s%s' (set_color 888888) (prompt_pwd) (__fish_git_prompt ' %s')

	switch $fish_bind_mode
		case default
			set_color 888888
			printf ' 🅽 '

		case replace_one
			set_color 8ec07c
			printf ' 🆁 '

		case visual
			set_color fe8019
			printf ' 🆅 '

		case '*'
			printf '   '
	end

	set_color normal
	printf '\n> '

end
