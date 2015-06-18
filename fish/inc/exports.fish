# Export AWS credentials from ~/.aws/credentials
set -x "AWS_ACCESS_KEY_ID" (grep -m 1 'aws_access_key_id' ~/.aws/credentials | sed 's/.*= *//')
set -x "AWS_SECRET_ACCESS_KEY" (grep -m 1 'aws_secret_access_key' ~/.aws/credentials | sed 's/.*= *//')
