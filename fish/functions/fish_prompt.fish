function fish_prompt -d 'Decorate the prompt'
	# Defaults
	set -l branch_name ''
	set -l prompt_character '>'
	set -l prompt_color '#ebdbb2'
	set -l pwd_color '#928374'

	set -l branch_color '#d79921'
	set -l clean_prompt_color '#98971a'
	set -l dirty_prompt_color '#d65d0e'
	set -l untracked_prompt_color '#b16286'

	# Is this a git repo?
	if git rev-parse --is-inside-work-tree >/dev/null 2>&1
		set -l git_status (git status --porcelain 2>/dev/null)
		set prompt_color "$clean_prompt_color"

		# Is the state dirty in any way?
		if test -n "$git_status"
			set -l git_status_no_untracked (echo "$git_status" | sed '/^??/d')

			# Is the state dirtier than just untracked files?
			if test -n "$git_status_no_untracked"
				set prompt_color "$dirty_prompt_color"
			else
				set prompt_color "$untracked_prompt_color"
			end
		end

		# Is the current branch different from the default branch at origin?
		set -l default_branch (git_default_branch)
		set -l current_branch (git_branch)
		if test "$default_branch" != "origin/$current_branch"
			set branch_name " $current_branch"
		end
	end

	printf '%s%s%s%s %s%s%s ' (set_color $pwd_color) (prompt_pwd) (set_color $branch_color) $branch_name (set_color --bold $prompt_color) $prompt_character (set_color normal)
end
