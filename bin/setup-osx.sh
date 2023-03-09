#!/usr/bin/env bash

set -euxo pipefail

# Only show open applications in the dock.
defaults write com.apple.dock static-only -bool true

# Auto-hide the dock.
defaults write com.apple.dock autohide -bool true

# Set the auto-hide delay to a high number to effectively hide it forever.
# Show it manually with Command+Option+D.
defaults write com.apple.dock autohide-delay -float 1000

# Show the application switcher on all displays.
defaults write com.apple.dock appswitcher-all-displays -bool true

# Allow text selection in QuickLook.
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

# Disable font-smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0

echo "Enter your password to restart applications."
sudo killall Dock
sudo killall Finder
