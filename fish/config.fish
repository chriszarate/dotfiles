set fish_greeting ""
set -x EDITOR vim
set -x PAGER less
set -x SHELL (which fish)
set -x SSH_AUTH_SOCK ~/.ssh/autoproxxy-ssh-agent.socket

# Don't rely on the order config files are parsed when setting $PATH, because it
# can change without warning. Do this in deliberate order.
fish_add_path --append --move $HOME/.bin $HOME/.orbstack/bin /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin
fnm env --use-on-cd --log-level error --shell fish | source
zoxide init fish | source
