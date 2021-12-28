function phpserver -d 'Start a PHP server in the current directory, pass a port as the first argument (default: 8000)'
	set "PORT" (or_default 8000 $argv[1])
	env DOCKER_RUN_OPTIONS="-p $PORT:$PORT" docker-run php:7.4-alpine php -S 0.0.0.0:$PORT
end
