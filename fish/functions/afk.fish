function afk -d 'Lock the screen'
	if [ (uname) = 'Darwin' ]
		pmset displaysleepnow
	end
end
