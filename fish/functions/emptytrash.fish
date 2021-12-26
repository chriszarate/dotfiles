function emptytrash -d 'Empty trash on all mounted volumes and clear system logs'
	if [ (uname) = 'Darwin' ]
		sudo rm -rfv /Volumes/*/.Trashes
		sudo rm -rfv ~/.Trash
		sudo rm -rfv /private/var/log/asl/*.asl
	end
end
