if [ (uname) = 'Darwin' ]

  # Empty the Trash on all mounted volumes and the main HDD
  # Also, clear Apple’s System Logs to improve shell startup speed
  alias emptytrash "sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

  # Lock the screen (when going AFK)
  alias afk "/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession -suspend"

  # Show/hide hidden and system files
  alias showhidden "defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
  alias hidehidden "defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

  # Allow/disallow text selection in QuickLook
  alias qltexton "defaults write com.apple.finder QLEnableTextSelection -bool TRUE; killall Finder"
  alias qltextoff "defaults write com.apple.finder QLEnableTextSelection -bool FALSE; killall Finder"

end
