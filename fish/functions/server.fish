function server -d 'Start an Nginx server in the current directory'
	# Not using docker-run because of nginx needs to run as root
	docker run --rm -it -p 8000:80 -v (pwd):/usr/share/nginx/html:ro nginx:alpine
end
