function git_prompt_pwd -d 'Display the working directory or the git origin, if applicable'
	set -l git_origin (git_origin)

  if test "$git_origin" != ""
    # Adapted from prompt_pwd.fish
    string replace -ar '(\.?[^/]{1})[^/]*/' '$1/' $git_origin
    printf ' %s' (git_branch)
  else
    prompt_pwd
  end
end
