function hidden -d 'Toggle whether to show hidden and system files in Finder'
	if [ (uname) = 'Darwin' ]
		if [ (defaults read com.apple.finder AppleShowAllFiles) = '0' ]
			defaults write com.apple.finder AppleShowAllFiles -boolean true
		else
			defaults write com.apple.finder AppleShowAllFiles -boolean false
		end

		killall Finder
	end
end
