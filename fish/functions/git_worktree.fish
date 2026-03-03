function git_worktree -d 'Return the current worktree name, or empty if not in a linked worktree'
	set -l wt_paths (git worktree list --porcelain 2>/dev/null | string replace -f 'worktree ' '')
	or return

	for wt_path in $wt_paths[2..]
		if string match -q "$wt_path" -- $PWD; or string match -q "$wt_path/*" -- $PWD
			printf "%s" (basename "$wt_path")
			return
		end
	end
end
