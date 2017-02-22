# Easier navigation: -, .., ..., ...., ..... (~ is built-in)
alias , "cd -"
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

# Easier listings
alias l "ls -lF"
alias la "ls -laF"
alias ll "ls -laF | less"

# Folder shortcuts
alias d="cd ~/Documents"
alias D="cd ~/Downloads"
alias L="cd ~/Library"
alias S="cd ~/Documents/Scratch"

# Search shortcuts
alias a="ag --ignore={build,build-directory,dist,vendor} --ignore='*[-.]min[-.]*' --ignore=bundle.js --ignore='*.json' --pager='less -R' -W 400"

# Show running EC2 instances in a nice table (uses aws-cli)
alias ec2show "aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Name:Tags[?Key==`Name`]|[0].Value, State:State.Name, ID:InstanceId, Type:InstanceType, Storage:RootDeviceType, Zone:Placement.AvailabilityZone, PublicIP:PublicIpAddress}' --output table"

# Generate a simple HTTP server on port 8000
alias server "python -m SimpleHTTPServer"

# Generate a PHP server on port 8000
alias phpserver "php -S localhost:8000"

# Reload fish config.
alias reload "source ~/.config/fish/config.fish"

# Redraw tmux window by detaching all other clients.
alias redraw "tmux detach -a"

# Wrap sqlplus in readline.
alias sqlplus "rlwrap sqlplus"

# Docker
alias dco docker-compose
alias dcrm "docker ps -qf status=exited | xargs docker rm"
alias dirm "docker images -qf dangling=true | xargs docker rmi"
alias dvrm "docker volume ls -qf dangling=true | xargs docker volume rm"
