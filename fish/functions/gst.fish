function gst -d 'Browse git stashes'
  if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
    echo -ne "Not a git directory!\n\n"
    return
  end

  git stash list --pretty='%C(yellow)%gd %<(14)%Cgreen%cr %C(blue)%gs' | fzf-tmux --ansi --no-multi --preview 'git stash show --color=always  -p {1}' | read -a -l stash; and git stash branch stash-(date +%Y%m%d%H%M) $stash[1]
end
