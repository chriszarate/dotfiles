function git-origin -d 'Extract a shorthand form of the remote Git origin, if it exists.'
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
  and git remote -v | sed -E -e 's/^origin[[:space:]]([^ ]+).*$/\1/gp;d' | sed -E -e '1!d' -e 's/^git@github\.com:(.+)\.git$/\1/' -e 's/^https:\/\/github\.com\/(.+)\.git$/HTTPS \1/'
end
