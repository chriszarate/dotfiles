fnm env --use-on-cd --log-level info --shell fish | source

# Explictly add the path to the fish so that we can better control order.
fish_add_path --append --move $FNM_MULTISHELL_PATH/bin
