set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showupstream 'verbose'

set __fish_git_prompt_color_bare blue
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_branch_detached red
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_merging red
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_stashstate blue
set __fish_git_prompt_color_untrackedfiles red
set __fish_git_prompt_color_upstream yellow

set __fish_git_prompt_char_cleanstate ''
set __fish_git_prompt_char_dirtystate ' ●'
set __fish_git_prompt_char_invalidstate ' ✗'
set __fish_git_prompt_char_stagedstate ' ●'
set __fish_git_prompt_char_stashstate ' ⚑'
set __fish_git_prompt_char_stateseparator ''
set __fish_git_prompt_char_untrackedfiles ' ○'
set __fish_git_prompt_char_upstream_ahead ' ▲'
set __fish_git_prompt_char_upstream_behind ' ▼'
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_diverged ' 🙈 '
set __fish_git_prompt_char_upstream_prefix ' ⥮'

function fish_prompt
  set -l last_status $status
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color 666666
  printf '%s' (__fish_git_prompt " @ %s ")
  set_color 666666
  printf '> '
end
