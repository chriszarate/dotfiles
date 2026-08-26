function afk -d 'Put the computer to sleep'
	if [ (uname) = 'Darwin' ]
		pmset displaysleepnow
	else if [ (uname) = 'Linux' ]
		systemctl suspend
	else
		echo "Unsupported operating system"
	end
end
