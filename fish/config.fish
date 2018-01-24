set fish_greeting ""
set fish_key_bindings fish_vi_key_bindings
set -x EDITOR vim

# Set initial window title.
echo -n -e "\033]0;~\007"

for file in ~/.config/fish/inc/*.fish ~/.*.fish
  source $file
end

# Always open a tmux session (unless we're nested in something).
switch (echo $TERM)
  case 'screen*'
  case '*'
    test -z "$ATOM_HOME"; and tmux attach -t (whoami) >/dev/null 2>&1; or tmux new-session -s (whoami)
end

# Connect to ssh-agent session (requires keychain).
eval (keychain --eval --quiet --agents ssh --nogui)
