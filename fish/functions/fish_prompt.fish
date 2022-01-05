function fish_prompt -d 'Decorate the prompt'
	switch $fish_bind_mode
		case default
			printf '%s%sN%s ' (set_color --background '#ebdbb2') (set_color '#282828') (set_color normal)

		case replace
		case replace_one
			printf '%s%sR%s ' (set_color --background '#b8bb26') (set_color '#282828') (set_color normal)

		case visual
			printf '%s%sV%s ' (set_color --background '#d3869b') (set_color '#282828') (set_color normal)

		case '*'
			printf '%s> ' (set_color normal)
	end
end
