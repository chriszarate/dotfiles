function fish_mode_prompt -d 'Leading prompt to indicate mode (normal, insert, visual, replace_one)'
	# Don't actually print anything, just change the cursor color in Kitty.
	switch $fish_bind_mode
		case default
			kitty @ set-colors 'cursor=#d79921'

		case replace_one
			kitty @ set-colors 'cursor=#689d6a'

		case visual
			kitty @ set-colors 'cursor=#b16286'

		case '*'
			kitty @ set-colors 'cursor=#ebdbb2'
	end
end
