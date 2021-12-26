function zzz -d 'Put the computer to sleep'
	if [ (uname) = 'Darwin' ]
		pmset sleepnow
	end
end
