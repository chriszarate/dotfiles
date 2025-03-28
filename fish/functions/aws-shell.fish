function aws-shell -d 'Run AWS CLI commands at a Bash prompt in a Docker container'
	env DOCKER_RUN_OPTIONS="-v $HOME/.aws:/root/.aws --entrypoint /bin/bash" DOCKER_RUN_AS_ROOT="true" docker-run amazon/aws-cli
end
