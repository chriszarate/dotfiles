function aws -d 'Run AWS CLI commands in a Docker container'
	env DOCKER_RUN_OPTIONS="-v $HOME/.aws:/root/.aws" DOCKER_RUN_AS_ROOT="true" docker-run amazon/aws-cli $argv
end
