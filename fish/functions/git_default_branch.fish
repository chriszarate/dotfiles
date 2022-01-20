function git_default_branch -d 'Extract the last-known default branch name of the Git repo.'
	git rev-parse --abbrev-ref origin/HEAD 2>/dev/null
end
