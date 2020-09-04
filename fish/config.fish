set fish_greeting ""
set -x EDITOR vim
set -x SHELL /usr/local/bin/fish

# Source local config.
for file in ~/.config/fish/inc/*.fish
  source $file
end
