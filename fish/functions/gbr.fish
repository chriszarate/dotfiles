function gbr -d 'Checkout a recent git branch'
  if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
    echo -ne "Not a git directory!\n\n"
    return
  end

  set -l branches (git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)")
  set -l branch (string join \n $branches | fzf-tmux --no-hscroll --no-multi --ansi --preview 'git --no-pager log -50 --pretty=format:"%h  %an (%ar)  %s" {}'); and git checkout $branch
end
