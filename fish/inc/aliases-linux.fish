if [ (uname) = 'Linux' ]
	# Docker is a lot better on Linux
	alias node      "docker-run node:10-alpine node"
	alias npm       "docker-run node:10-alpine npm"
end
