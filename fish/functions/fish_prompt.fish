function fish_prompt
  git_status_tmux
  printf '\n%s> ' (set_color 666666)
end
