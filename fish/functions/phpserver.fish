function phpserver -d 'Start a PHP server in the current directory'
	env DOCKER_RUN_OPTIONS="-p 8000:8000" docker-run php:7.4-alpine php -S 0.0.0.0:8000
end
