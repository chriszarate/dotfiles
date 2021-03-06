# Export fzf overrides
set -g "FZF_ALT_C_COMMAND" "fd --type d --hidden"
set -g "FZF_CTRL_T_COMMAND" "fd --type f --hidden"
set -g "FZF_CTRL_T_OPTS" "--preview 'bat --color always --number {}'"
set -gx "FZF_DEFAULT_OPTS" "--bind ctrl-a:select-all --exact --history=$HOME/.config/fzf/history"
