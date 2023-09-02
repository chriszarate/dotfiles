function fish_prompt -d 'Decorate the prompt'
	# Defaults
	set -l prompt_character '>'
	set -l prompt_color '#a89984'
	set -l pwd_color '#928374'

	set -l branch_prompt_color '#98971a'
	set -l conflict_prompt_color '#d65d0e'
	set -l dirty_prompt_color '#d79921'
	set -l untracked_prompt_color '#b16286'

	# Is this a git repo?
	if git rev-parse --is-inside-work-tree >/dev/null 2>&1
		set -l git_status (git status -s --ignore-submodules=dirty 2>/dev/null)

		# Is the state dirty in any way?
		if test -n "$git_status"
			set -l git_status_has_conflicts (echo "$git_status" | sed -nE '/^[ADU]{2}/p')
			set -l git_status_no_untracked (echo "$git_status" | sed '/^??/d')

			# Is the state dirty with conflicts?
			if test -n "$git_status_has_conflicts"
				set prompt_color "$conflict_prompt_color"
			# Is the state dirtier than just untracked files?
			else if test -n "$git_status_no_untracked"
				set prompt_color "$dirty_prompt_color"
			else
				set prompt_color "$untracked_prompt_color"
			end
		else
			# Is the current branch different from the default branch at origin?
			set -l default_branch (git_default_branch)
			set -l current_branch (git_branch)
			if test "$default_branch" != "origin/$current_branch"
				set prompt_color "$branch_prompt_color"
			end
		end
	end

	printf '%s%s %s%s%s ' (set_color $pwd_color) (prompt_pwd) (set_color --bold $prompt_color) $prompt_character (set_color normal)
end
