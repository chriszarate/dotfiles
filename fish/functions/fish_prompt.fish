function fish_prompt
	printf '\n%s%s %s\n%s> %s' (set_color 888888) (prompt_pwd) (git_status) (set_color ebdbb2) (set_color normal)
end
