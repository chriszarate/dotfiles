function fish_right_prompt -d 'Decorate the right-side prompt'
	printf '%s%s' (set_color '#fabd2f') (string replace -r '^ \((.+)\)$' ' $1' (fish_git_prompt))
end
