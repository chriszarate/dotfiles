function dvrm -d 'Remove unused Docker volumes'
	docker volume ls -qf dangling=true | xargs docker volume rm
end
