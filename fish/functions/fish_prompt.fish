function fish_prompt -d 'Decorate the prompt'
	printf '%s%s%s > ' (fish_prompt_color) (prompt_pwd) (set_color normal)
end
