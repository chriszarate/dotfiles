# Export fzf overrides
set -g "FZF_ALT_C_COMMAND" "fd -t d"
set -g "FZF_CTRL_T_COMMAND" "fd -t f"
set -g "FZF_CTRL_T_OPTS" "--preview 'bat --color always --number {}'"
