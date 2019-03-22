function copy -d 'Copy piped text to clipboard'
  if [ (uname) = 'Darwin' ]
    pbcopy $argv
  end

  if [ (uname) = 'Linux' ]
    xclip -sel clip $argv
  end
end

function o -d 'Open a file or URL'
  if [ (uname) = 'Darwin' ]
    open $argv
  end

  if [ (uname) = 'Linux' ]
    switch $argv
      case "http*"
        xdg-open $argv
      case "*"
        open $argv
    end
  end
end

function timer -d 'A stopwatch using `time`.'
  echo "Timer started. Stop with Ctrl-D."
  date
  time cat
  date
end

function emptytrash -d 'Empty trash on all mounted volumes and clear system logs'
	if [ (uname) = 'Darwin' ]
		sudo rm -rfv /Volumes/*/.Trashes
		sudo rm -rfv ~/.Trash
		sudo rm -rfv /private/var/log/asl/*.asl
	end
end

function afk -d 'Lock the screen'
	if [ (uname) = 'Darwin' ]
		/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession -suspend
	end
end

function showhidden -d 'Show hidden and system files'
	if [ (uname) = 'Darwin' ]
		defaults write com.apple.finder AppleShowAllFiles YES
		killall Finder
	end
end

function hidehidden -d 'Hide hidden and system files'
	if [ (uname) = 'Darwin' ]
		defaults write com.apple.finder AppleShowAllFiles NO
		killall Finder
	end
end

if [ (uname) = 'Darwin' ]
	function qltexton -d 'Allow text selection in QuickLook'
		defaults write com.apple.finder QLEnableTextSelection -bool TRUE
		killall Finder
	end
end

