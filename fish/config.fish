set fish_greeting ""
set -x EDITOR (which vim)
set -x SHELL (which fish)
set -x GOPATH "$HOME/.go"

fish_add_path /opt/homebrew/bin /usr/local/bin $GOPATH/bin

# Prefer ARM64 if available.
if string match -q "*ARM64*" (uname -a)
  set -x HOMEBREW_CHANGE_ARCH_TO_ARM 1
end

# Source local config.
for file in ~/.config/fish/inc/*.fish
  source $file
end
