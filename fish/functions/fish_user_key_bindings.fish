function fish_user_key_bindings -d 'Set key bindings for users at the shell'
	# Restore default bindings with fish_default_key_bindings
	set -U fish_cursor_default underscore
	set -U fish_cursor_insert block
	set -U fish_cursor_visual line

	fish_vi_key_bindings
	fzf_key_bindings
end
