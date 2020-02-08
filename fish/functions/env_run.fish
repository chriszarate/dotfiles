function env_run -d "Source a file of environment variables and run a program with those variables exposed"
	for i in (/bin/cat $argv[1])
		set arr (echo $i | tr = \n)
		set -x "$arr[1]" "$arr[2]"
	end
	$argv[2]
end
