function git_prompt_pwd -d 'Display the working directory or the git origin, if applicable'
  set -l git_origin (git_origin)

  if test "$git_origin" != ""
    # Adapted from prompt_pwd.fish
    printf '%s' (string replace -ar '(\.?[^/]{1})[^/]*/' '$1/' $git_origin)
  else
    prompt_pwd
  end
end
