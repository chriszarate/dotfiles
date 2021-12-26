function hidden -d 'Toggle whether to show hidden and system files in Finder'
	if [ (uname) = 'Darwin' ]
		defaults write com.apple.finder AppleShowAllFiles YES
		killall Finder
	end
end
