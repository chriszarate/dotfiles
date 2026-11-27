function herdr-remote -d 'Connect to a remote herdr session using its keybindings'
	if test (count $argv) -ne 1; or test -z "$argv[1]"
		echo 'Usage: herdr-remote HOST' >&2
		return 2
	end

	# Mark the kitty window so that kitty/inc/maps.conf passes the shared
	# shortcuts through to herdr. The values are base64 for 1 and 0.
	printf '\e]1337;SetUserVar=in_herdr=MQ==\a'
	command herdr --remote "$argv[1]" --remote-keybindings server
	set -l herdr_status $status
	printf '\e]1337;SetUserVar=in_herdr=MA==\a'
	return $herdr_status
end
