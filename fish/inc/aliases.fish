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

# Stopwatch
alias timer 'echo "Timer started. Stop with Ctrl-D."; date; time cat; date'

# IP addresses
alias publicip "dig +short myip.opendns.com @resolver1.opendns.com"
alias ips "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show running EC2 instances in a nice table (uses aws-cli)
alias ec2show "aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Name:Tags[?Key==\`Name\`]|[0].Value, State:State.Name, ID:InstanceId, Type:InstanceType, Storage:RootDeviceType, Zone:Placement.AvailabilityZone, PublicIP:PublicIpAddress}' --output table"

# Generate a simple HTTP server on port 8000
alias server "python -m SimpleHTTPServer"

# Generate a PHP server on port 8000
alias phpserver "php -S localhost:8000"

# Redraw tmux window by detaching all other clients.
alias redraw "tmux detach -a"
