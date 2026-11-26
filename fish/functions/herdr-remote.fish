function herdr-remote -d 'Connect to a remote herdr session using its keybindings'
	if test (count $argv) -ne 1; or test -z "$argv[1]"
		echo 'Usage: herdr-remote HOST' >&2
		return 2
	end

	command herdr --remote "$argv[1]" --remote-keybindings server
end
