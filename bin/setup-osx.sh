#!/usr/bin/env bash

# Only show open applications in the dock.
defaults write com.apple.dock static-only -bool true

# Put the dock on the right.
defaults write com.apple.dock orientation -string right

# Auto-hide the dock.
defaults write com.apple.dock autohide -bool true

# Allow text selection in QuickLook.
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

echo "Enter your password to restart applications."
sudo killall Dock
sudo killall Finder
