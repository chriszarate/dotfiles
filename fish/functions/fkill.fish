function fkill -d 'Use fzf to find and kill a process'
	set -l pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if test "$pid" != ""
		echo $pid | xargs kill $argv
	end
end
