# Export Docker local IP. With Docker beta, this is actual local.
set -x "DOCKER_LOCAL_IP" (ifconfig | grep "inet " | grep -v -m 1 127.0.0.1 | awk '{print $2}')

# Export AWS credentials from ~/.aws/credentials
set -x "AWS_ACCESS_KEY_ID" (grep -i -m 1 'aws_access_key_id' ~/.aws/credentials | sed 's/.*= *//')
set -x "AWS_SECRET_ACCESS_KEY" (grep -i -m 1 'aws_secret_access_key' ~/.aws/credentials | sed 's/.*= *//')

# Export fzf overrides
set -g "FZF_CTRL_T_COMMAND" "fd -t f"
set -g "FZF_CTRL_T_OPTS" "--preview 'bat {}'"
set -g "FZF_TMUX" "1"
