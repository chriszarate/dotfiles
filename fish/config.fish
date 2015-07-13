set fish_greeting ""

set fish_key_bindings fish_vi_key_bindings

for file in aliases exports
  source ~/.config/fish/inc/$file.fish
end

if [ (uname) = 'Darwin' ]
  source ~/.config/fish/inc/aliases-osx.fish
end

# Always open a tmux session.
switch $TERM
  case 'screen*'
  case '*'
    tmux attach -t (whoami) >/dev/null 2>&1; or tmux new-session -s (whoami)
end

# Connect to ssh-agent session (requires keychain).
eval (keychain --eval --quiet --agents ssh --nogui)
