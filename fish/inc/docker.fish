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

function aws -d 'AWS CLI'
	env DOCKER_RUN_OPTIONS="-v $HOME/.aws:/.aws" docker-run mesosphere/aws-cli $argv
end

function composer -d 'PHP Composer 1.8'
	docker-run composer:1.8 $argv
end

function ffmpeg -d 'ffmpeg'
	env DOCKER_WORKDIR="/tmp" docker-run jrottenberg/ffmpeg $argv
end

function go -d 'Golang'
	env DOCKER_RUN_OPTIONS="-v $HOME/.cache:/.cache" docker-run golang go $argv
end

function mysql -d 'MariaDB 10'
	docker-run mariadb:10 mysql $argv
end

function php -d 'PHP 7.1'
	docker-run php:7.1-alpine php $argv
end

function phpcs -d 'PHP CodeSniffer'
	docker-run wpengine/phpcs $argv
end

function phpmd -d 'PHP Mess Detector'
	docker-run dockerizedphp/phpmd $argv
end

function phpserver -d 'Start a PHP server in the current directory'
	docker-run php:7.1-alpine php -S 127.0.0.1:8000
end

function phpunit -d 'PHPUnit'
	docker-run phpunit/phpunit $argv
end

function psql -d 'PostGreSQL 11'
	docker-run postgres:11-alpine psql $argv
end

function ruby -d 'Ruby 2.6'
	docker-run ruby:2.6-alpine ruby $argv
end

function server -d 'Start an Nginx server in the current directory'
	docker run --rm -v (pwd):/usr/share/nginx/html:ro -p 8000:80 nginx:alpine
end

function shell -d 'Start my own customized shell in a docker container'
	docker-run chriszarate/shell bash $argv
end

function slack -d 'Sclack'
	docker run --rm -it -v $HOME/.sclack:/root/.sclack matsuu/sclack $argv
end

function wp -d 'Execute WP-CLI in a Docker Compose environment'
	docker-compose exec --user www-data wordpress wp $argv
end
