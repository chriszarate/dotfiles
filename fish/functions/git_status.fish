function git_status -d "Provide a simple but detailed git status in an environment variable."
	set -l output (__fish_git_prompt '%s')

	if [ "$output" != '' ]
		set -l stash (git stash list 2>/dev/null | wc -l | awk '{print $1}')
		if [ "$stash" != '0' ]
			set -a output (set_color $__fish_git_prompt_color_stashstate)"$__fish_git_prompt_char_stashstate$stash"
		end
  end

	echo $output
end
