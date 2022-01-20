function git_branch -d 'Extract the checked-out branch name of the Git repo.'
  git rev-parse --abbrev-ref HEAD 2>/dev/null
end
