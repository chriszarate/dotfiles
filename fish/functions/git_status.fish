function git_status -d "Provide a simple but detailed git status in an environment variable."
	set -l output (__fish_git_prompt '%s')

	if [ "$output" != '' ]
		set -l stash (git stash list 2>/dev/null | wc -l | awk '{print $1}')
		if [ "$stash" != '0' ]
			set -a -l output "$__fish_git_prompt_char_stashstate$stash"
		end

		# Remove colors (it would be a pain to translate these outside of fish).
		echo $output | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"
	else
		echo ''
  end
end
