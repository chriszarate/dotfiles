function git_status_tmux -d "Provide a simple but detailed git status in tmux."
  set -l git_prompt (__fish_git_prompt '%s')
  set -l git_stash '0'

  if [ "$git_prompt" != '' ]
    set git_stash (git stash list 2>/dev/null | wc -l | awk '{print $1}')
    if [ "$git_stash" != '0' ]
      set git_prompt "$git_prompt$__fish_git_prompt_char_stashstate$git_stash"
    end

    # Remove colors (it would be a pain to translate these for tmux).
    set git_prompt (echo " $git_prompt " | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g")
  end

  # Update tmux pane border with git status instead of displaying repetitively
  # in prompt.
  tmux set-window-option "pane-border-format" "#{?pane_active,$git_prompt,}"
end

