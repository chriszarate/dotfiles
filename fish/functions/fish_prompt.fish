set __fish_git_prompt_describe_style 'branch'
set __fish_git_prompt_show_informative_status true

set __fish_git_prompt_color 666666
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
set __fish_git_prompt_char_upstream_prefix ''

function fish_prompt
  set -l git_prompt (__fish_git_prompt '@ %s')
  if [ "$git_prompt" != '' ]
    echo ""
    printf '%s%s %s' (set_color 666666) (git_origin) $git_prompt
    set -l git_stash (git stash list 2>/dev/null | wc -l | awk '{print $1}')
    if [ "$git_stash" != '0' ]
      printf '%s' "$___fish_git_prompt_color_stashstate$__fish_git_prompt_char_stashstate$git_stash"
    end
    echo ""
  end

  printf '%s%s%s > ' (set_color green) (prompt_pwd) (set_color 666666)
end
