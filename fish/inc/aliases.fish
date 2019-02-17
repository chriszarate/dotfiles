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

# Don't install stuff.
alias aws       "env DOCKER_RUN_OPTIONS='-v $HOME/.aws:/.aws' docker-run mesosphere/aws-cli"
alias composer  "docker-run composer:1.8"
alias go        "env DOCKER_RUN_OPTIONS='-v $HOME/.cache:/.cache' docker-run golang go"
alias mysql     "docker-run mariadb:10 mysql"
alias nbg       "docker-run digitallyseamless/nodejs-bower-grunt"
alias php       "docker-run php:7.1-alpine php"
alias phpcs     "docker-run wpengine/phpcs"
alias phpmd     "docker-run dockerizedphp/phpmd"
alias phpserver "docker-run php:7.1-alpine php -S 127.0.0.1:8000"
alias phpunit   "docker-run phpunit/phpunit"
alias psql      "docker-run postgres:11-alpine psql"
alias python    "docker-run python:3-alpine python"
alias ruby      "docker-run ruby:2.6-alpine ruby"
alias server    "docker run --rm -v (pwd):/usr/share/nginx/html:ro -p 8000:80 nginx:alpine"
alias shell     "docker-run chriszarate/shell bash"
alias wp        "docker-compose exec --user www-data wordpress wp"

# GraphQL
alias torelay   "node -e \"process.stdout.write(Buffer.from(process.argv[1]+':'+process.argv[2]).toString('base64'));\""
alias fromrelay "node -e \"process.stdout.write(Buffer.from(process.argv[1], 'base64').toString().split(':')[1]);\""
