set -g FZF_ALT_C_COMMAND "fd --type d --hidden"
set -g FZF_CTRL_T_COMMAND "fd --type f --hidden"
set -g FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=changes,numbers {}'"
set -gx FZF_DEFAULT_COMMAND "$FZF_CTRL_T_COMMAND"
set -gx FZF_DEFAULT_OPTS "--bind ctrl-a:select-all --exact --history=$HOME/.config/fzf/history"

# Source key bindings from dist
if test -f /opt/homebrew/opt/fzf/shell/key-bindings.fish
	source /opt/homebrew/opt/fzf/shell/key-bindings.fish
end
