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
alias d "cd ~/Documents"
alias D "cd ~/Downloads"
alias L "cd ~/Library"
alias S "cd ~/Documents/Scratch"

# Search shortcuts
alias a "ag --ignore={build,build-directory,dist,node_modules,vendor} --ignore='*[-.]min[-.]*' --ignore=bundle.js --ignore='*.json' --pager='less -R' -W 400"

# Alternatives
alias cat "bat"
alias ping "prettyping --nolegend"
alias top "sudo htop"

# Show running EC2 instances in a nice table (uses aws-cli)
alias ec2show "aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Name:Tags[?Key==`Name`]|[0].Value, State:State.Name, ID:InstanceId, Type:InstanceType, Storage:RootDeviceType, Zone:Placement.AvailabilityZone, PublicIP:PublicIpAddress}' --output table"

# Recursively delete `.DS_Store` files
alias cleanup "find . -type f -name '*.DS_Store' -ls -delete"

# Reload fish config.
alias reload "source ~/.config/fish/config.fish"

# Redraw tmux window by detaching all other clients.
alias redraw "tmux detach -a"

# Git
alias gh "o https://github.com/(git-origin)/tree/(git-branch)"
alias ghi "o https://github.com/(git-origin)/issues"
alias ghp "o https://github.com/(git-origin)/pulls"

# Docker
alias dco docker-compose
alias dcrm "docker ps -qf status=exited | xargs docker rm"
alias dirm "docker images -qf dangling=true | xargs docker rmi"
alias dvrm "docker volume ls -qf dangling=true | xargs docker volume rm"

# https://github.com/michaloo/drun
# Note: Host networking only works on Linux.
alias drun='docker run -u (id -u):(id -g) -v (pwd):/app --workdir /app -it --rm --network=host'

# Don't install stuff.
alias mysql     "drun mariadb:10 mysql"
alias node      "drun node:10-alpine node"
alias nbg       "drun digitallyseamless/nodejs-bower-grunt"
alias npm       "drun node:10-alpine npm"
alias php       "drun php:7.1-alpine php"
alias phpserver "drun php:7.1-alpine php -S 127.0.0.1:8000"
alias phpunit   "drun phpunit/phpunit"
alias psql      "drun postgres:11-alpine psql"
alias python    "drun python:3-alpine python"
alias ruby      "drun ruby:2.6-alpine ruby"
alias server    "docker run --rm -v (pwd):/usr/share/nginx/html:ro -p 8000:80 nginx:alpine"
alias shell     "drun chriszarate/shell bash"
alias wp        "docker-compose exec --user www-data wordpress wp"
