# Easier navigation: -, .., ..., ...., ..... (~ is built-in)
alias - "cd -"
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

# Git user aliases
alias ]co "git checkout"
alias ]f "git fetch"
alias ]p  "git pull"
alias ]pu "git push"
alias ]s  "git status --short --branch"
alias ]b  "git branch"
alias ]a  "git add"
alias ]ap "git add --patch"
alias ]c  "git commit"
alias ]ca "git commit --amend"
alias ]d  "git diff"
alias ]dc "git diff --cached"
alias ]l  "git log --oneline"
alias ]ll "git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

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
