function fish_prompt -d 'Decorate the prompt'
	printf '%s%s' (set_color '#928374') (prompt_pwd)
	printf '%s%s' (set_color '#b57614') (fish_git_prompt)
	printf ' %s$%s ' (set_color '#a89984') (set_color normal)
end
