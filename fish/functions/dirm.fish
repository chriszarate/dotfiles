function dirm -d 'Remove unused Docker images'
	docker images -qf dangling=true | xargs docker rmi
end
