function fish_right_prompt
  set_color 666666
  printf '%s' (__is_git; and __git_origin)
end
