# Export Brewfile path.
set -x HOMEBREW_BUNDLE_FILE "$HOME/.Brewfile"

# Disable auto-updates for casks.
set -x HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS "1"

# Prefer ARM64 if available.
if string match -q "*ARM64*" (uname -a)
  set -x HOMEBREW_CHANGE_ARCH_TO_ARM "1"
end
