function fish_prompt -d 'Decorate the prompt'
	# Capture early.
	set -l last_status $status

	# Defaults
	set -l prompt_character '>'
	set -l prompt_color '#a89984'
	set -l problem_indicator ''
	set -l subshell_indicator ''

	set -l branch_prompt_color '#98971a'
	set -l conflict_prompt_color '#d65d0e'
	set -l dirty_prompt_color '#d79921'
	set -l untracked_prompt_color '#b16286'

	# Is this a git repo?
	if git rev-parse --is-inside-work-tree >/dev/null 2>&1
		set -l git_status (git status -s --ignore-submodules=dirty 2>/dev/null)

		# Is the current branch different from the default branch at origin?
		set -l default_branch (git_default_branch)
		set -l current_branch (git_branch)
		if test "$default_branch" != "origin/$current_branch"
			set prompt_color "$branch_prompt_color"
		end

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
		end
	end

	# Last command returned a non-zero exit code?
	if test $last_status -ne 0
		if test $last_status -gt 1
			set problem_indicator (string join '' (set_color --bold '#fb4934') '*' $last_status (set_color --bold $prompt_color) ' ')
		else
			set problem_indicator (string join '' (set_color --bold '#fb4934') '*' (set_color --bold $prompt_color))
		end
	end

	# Running a subshell inside another program?
	if test -n "$YAZI_LEVEL"
		set subshell_indicator "<"
	else if test -n "$STY"
		set subshell_indicator "<"
	end

	string join '' (set_color --bold $prompt_color) $subshell_indicator $problem_indicator $prompt_character (set_color normal) ' '
end
