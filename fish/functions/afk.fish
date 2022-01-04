function afk -d 'Put the computer to sleep'
	if [ (uname) = 'Darwin' ]
		pmset displaysleepnow
	end
end
