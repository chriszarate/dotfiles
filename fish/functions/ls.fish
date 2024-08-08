function ls --wraps=eza -d 'Use eza instead of ls'
	set --erase -g last_known_pwd # force printing path in fish_right_prompt
	eza $argv
end
