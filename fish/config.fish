set fish_greeting ""

# Homebrew can go in different places.
if test -x "/opt/homebrew/bin/fish"
  set -x SHELL /opt/homebrew/bin/fish
else if test -x "/usr/local/bin/fish"
  set -x SHELL /usr/local/bin/fish
end

set -x EDITOR vim
set -U fish_user_paths /opt/homebrew/bin /usr/local/bin $fish_user_paths

# Source local config.
for file in ~/.config/fish/inc/*.fish
  source $file
end
