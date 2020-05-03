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
		/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
	end
end

function zzz -d 'Put the computer to sleep'
	if [ (uname) = 'Darwin' ]
		pmset sleepnow
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
