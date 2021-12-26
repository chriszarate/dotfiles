set fish_greeting ""
set -x EDITOR (which vim)
set -x SHELL (which fish)

fish_add_path /usr/local/bin $HOME/.bin

# Source local config.
for file in ~/.config/fish/inc/**/*.fish
  source $file
end
