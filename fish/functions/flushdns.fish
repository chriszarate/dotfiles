function flushdns -d "Flush DNS cache"
	if test (uname) = "Linux"
		sudo systemd-resolve --flush-caches
	else if test (uname) = "Darwin"
		sudo dscacheutil -flushcache
		sudo killall -HUP mDNSResponder
	else
		echo "Unsupported operating system: (uname)"
	end
end
