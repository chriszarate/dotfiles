function dco -d 'Docker Compose'
	docker-compose $argv
end

function dcrm -d 'Remove exited Docker containers'
	docker ps -qf status=exited | xargs docker rm
end

function dirm -d 'Remove unused Docker images'
	docker images -qf dangling=true | xargs docker rmi
end

function dvrm -d 'Remove unused Docker volumes'
	docker volume ls -qf dangling=true | xargs docker volume rm
end

function phpserver -d 'Start a PHP server in the current directory'
	env DOCKER_RUN_OPTIONS="-p 8000:8000" docker-run php:7.3-alpine php -S 0.0.0.0:8000
end

function server -d 'Start an Nginx server in the current directory'
	# Not using docker-run because of nginx needs to run as root
	docker run --rm -it -p 8000:80 -v (pwd):/usr/share/nginx/html:ro nginx:alpine
end
