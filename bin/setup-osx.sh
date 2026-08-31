#!/usr/bin/env bash

set -euo pipefail

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

# Allow key repeats, and make them fast. Turning off press-and-hold only
# enables repeating; these two set how quickly it happens. Both are measured
# in 15ms ticks, so 2 is about 30ms between repeats and 15 is a 225ms wait
# before repeating starts. The Keyboard pane bottoms out at 2 and 15.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable font-smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0

# No sudo: these are the current user's own processes, and asking for a
# password was the only thing that made this script need one.
killall Dock
killall Finder
