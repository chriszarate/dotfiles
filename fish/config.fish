set fish_greeting ""
set fish_key_bindings fish_vi_key_bindings
set EDITOR vi

for file in ~/.config/fish/inc/*.fish ~/.*.fish
  source $file
end

# Always open a tmux session.
switch $TERM
  case 'screen*'
  case '*'
    tmux attach -t (whoami) >/dev/null 2>&1; or tmux new-session -s (whoami)
end

# Connect to ssh-agent session (requires keychain).
eval (keychain --eval --quiet --agents ssh --nogui)
