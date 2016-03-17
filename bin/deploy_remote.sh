#!/bin/bash

# USAGE
# ./deploy_remote.sh path/to/file remote/path/to/file host1 host2 ...

# Required input
local_file=$1
remote_file=$2
host1=$3

if [[ -f $local_file && -n $remote_file && -n $host1 ]]; then

  # Loop through each host and upload the file
  for host in "${@:3}"; do
    scp "$local_file" "${host}:${remote_file}"
  done

else
  echo "Missing required argument."
  echo "/deploy_remote.sh path/to/file remote/path/to/file host1 host2 ..."
  echo ""
fi

