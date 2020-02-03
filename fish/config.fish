set fish_greeting ""
set -x EDITOR vim

# Source local config.
for file in ~/.config/fish/inc/*.fish
  source $file
end
