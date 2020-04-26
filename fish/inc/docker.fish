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
	docker-run php:7.3-alpine php -S 127.0.0.1:8000
end

function server -d 'Start an Nginx server in the current directory'
	env DOCKER_RUN_OPTIONS="-p 8000:80" DOCKER_WORKDIR="/usr/share/nginx/html" docker-run nginx:alpine
end

function shell -d 'Start my own customized shell in a docker container'
	docker-run chriszarate/shell bash $argv
end

function slack -d 'Sclack'
	docker run --rm -it -v $HOME/.sclack:/root/.sclack matsuu/sclack $argv
end

function wp -d 'Execute WP-CLI in a Docker Compose environment'
	docker-compose run --rm wp-cli wp $argv
end
