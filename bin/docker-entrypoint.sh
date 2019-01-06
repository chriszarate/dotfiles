#!/bin/bash
set -e

# Modify the docker user to use the selected UID, if provided.
if [ -n "$DOCKER_UID" ]; then
  usermod -u $DOCKER_UID docker
fi

# Set "HOME" ENV variable for user's home directory.
export HOME=/home/docker

# Execute process.
exec "$@"
