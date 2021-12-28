function server -d 'Start an Nginx server in the current directory, pass a port as the first argument (default: 8000)'
	set "PORT" (or_default 8000 $argv[1])

	# Not using docker-run because of nginx needs to run as root
	docker run --rm -it -p "$PORT:80" -v (pwd):/usr/share/nginx/html:ro nginx:alpine
end
