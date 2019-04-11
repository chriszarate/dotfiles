set fish_greeting ""
set fish_key_bindings fish_vi_key_bindings
set -x EDITOR vim

# Source local config.
for file in ~/.config/fish/inc/*.fish
  source $file
end

# Open a tmux session if one doesn't exist.
tmux has-session; or tmux new-session -s (whoami)
