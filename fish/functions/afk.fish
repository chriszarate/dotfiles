function afk -d 'Lock the screen'
	if [ (uname) = 'Darwin' ]
		/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
	end
end
