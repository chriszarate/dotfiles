fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin $HOME/.bin

# Export Brewfile path.
set -x "HOMEBREW_BUNDLE_FILE" "~/.Brewfile"

# Prefer ARM64 if available.
if string match -q "*ARM64*" (uname -a)
  set -x "HOMEBREW_CHANGE_ARCH_TO_ARM" "1"
end
