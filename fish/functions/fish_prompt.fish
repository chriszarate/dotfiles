set __fish_git_prompt_describe_style 'branch'
set __fish_git_prompt_show_informative_status true

set __fish_git_prompt_char_cleanstate ''
set __fish_git_prompt_char_dirtystate ' ◒'
set __fish_git_prompt_char_invalidstate ' (╯°□°)╯︵'
set __fish_git_prompt_char_stagedstate ' ●'
set __fish_git_prompt_char_stashstate ' ◆'
set __fish_git_prompt_char_stateseparator ''
set __fish_git_prompt_char_untrackedfiles ' ○'
set __fish_git_prompt_char_upstream_ahead ' ▲'
set __fish_git_prompt_char_upstream_behind ' ▼'
set __fish_git_prompt_char_upstream_prefix ''

function fish_prompt
  git_status_tmux
  printf '\n%s> ' (set_color 666666)
end
