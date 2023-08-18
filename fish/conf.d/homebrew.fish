# Note: This is fortuitously sourced after fnm.fish so that Homebrew paths have
# lower priority, allowing fnm to take precedence.
fish_add_path --append --move $HOME/.bin /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin

# Export Brewfile path.
set -x HOMEBREW_BUNDLE_FILE "$HOME/.Brewfile"

# Prefer ARM64 if available.
if string match -q "*ARM64*" (uname -a)
  set -x HOMEBREW_CHANGE_ARCH_TO_ARM "1"
end
