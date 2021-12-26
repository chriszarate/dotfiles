function dcrm -d 'Remove exited Docker containers'
	docker ps -qf status=exited | xargs docker rm
end
