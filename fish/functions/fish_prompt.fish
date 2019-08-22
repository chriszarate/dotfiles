function fish_prompt
	printf '\n%s%s %s\n%s> %s' (set_color a89984) (prompt_pwd) (git_status) (set_color a89984) (set_color normal)
end
