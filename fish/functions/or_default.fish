function or_default -d 'Return argument 2 if defined or fallback to argument 1'
	if set -q argv[2]
		echo $argv[2]
	else
		echo $argv[1]
	end
end
