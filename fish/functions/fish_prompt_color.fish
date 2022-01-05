function fish_prompt_color -d 'Set the color according to git status'
	set -l no_git_color '#a89984'
	set -l clean_color '#98971a'
	set -l dirty_color '#d65d0e'

	if git rev-parse --is-inside-work-tree >/dev/null 2>&1
		if string length (git status --short) >/dev/null
			set_color $dirty_color
		else
			set_color $clean_color
		end
	else
		set_color $no_git_color
	end
end
