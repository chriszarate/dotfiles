# Easier navigation: .., ..., ...., ....., ~ and -
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

# List all files colorized in long format
alias l "ls -lF"

# List all files colorized in long format, including dot files
alias la "ls -laF"

# List all files in long format, piped through `less`
alias ll "ls -laF | less"

# Enable aliases to be sudo’ed
alias sudo "sudo "

# Git utilities
alias __is_git "git rev-parse --is-inside-work-tree >/dev/null 2>&1"
alias __git_origin "git remote -v | sed -E -e 's/^origin.*github.com[:\/]([^ ]+).git.*/\1/' -e '1!d'"
alias __git_branch "git rev-parse --abbrev-ref HEAD"

# Git user aliases
alias ]co "git checkout"
alias ]f "git fetch"
alias ]p  "git pull"
alias ]pu "git push"
alias ]s  "git status --short --branch"
alias ]a  "git add"
alias ]ap "git add --patch"
alias ]c  "git commit"
alias ]d  "git diff"
alias ]dc "git diff --cached"
alias ]l  "git log --oneline"
alias ]ll "git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# Stopwatch
alias timer 'echo "Timer started. Stop with Ctrl-D."; date; time cat; date'

# IP addresses
alias publicip "dig +short myip.opendns.com @resolver1.opendns.com"
alias ips "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show running EC2 instances in a nice table (uses aws-cli)
alias ec2show "aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Name:Tags[?Key==`Name`]|[0].Value, State:State.Name, ID:InstanceId, Type:InstanceType, Storage:RootDeviceType, Zone:Placement.AvailabilityZone, PublicIP:PublicIpAddress}' --output table"

# Generate a simple HTTP server on port 8000
alias server "python -m SimpleHTTPServer"

# Generate a PHP server on port 8000
alias phpserver "php -S localhost:8000"

# Redraw tmux window by detaching all other clients.
alias redraw "tmux detach -a"
