function git-origin -d 'Extract a shorthand form of the remote Git origin, if it exists.'
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
  and git remote -v | sed -E -e 's/^origin.*github.com[:\/]([^ ]+).*/\1/' -e 's/\.git$//' -e '1!d'
end
