function git-branch -d 'Extract the checked-out branch name of the Git repo.'
  git rev-parse --abbrev-ref HEAD
end
