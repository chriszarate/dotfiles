function timer -d 'A stopwatch using `time`.' --wraps time
	echo "Timer started. Stop with Ctrl-D."
	date
	time command cat
	date
end
