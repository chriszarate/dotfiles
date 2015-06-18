function fish_right_prompt
  set_color 666666
  printf '%s' (is-git; and git-origin)
end
