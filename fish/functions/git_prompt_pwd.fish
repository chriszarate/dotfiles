function git_prompt_pwd -d ''
  set -l git_origin (git_origin)

  if test "$git_origin" != ""
    # Adapted from prompt_pwd.fish
    string replace -ar '(\.?[^/]{1})[^/]*/' '$1/' $git_origin
  else
    prompt_pwd
  end
end
