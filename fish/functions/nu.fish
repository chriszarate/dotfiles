function nu --wraps=npm -d 'Update dependencies (use -D for devDependencies)'
	set -l target 'dependencies'
	if test "$argv[1]" = '-D'; or test "$argv[1]" = '--save-dev'
		set target 'devDependencies'
	end

	npm outdated --json --long \
		| jq "to_entries | .[] | select(.value.type == \"$target\") | .key + \"@latest\"" \
		| fzf --header "Select $target to update" -m \
		| xargs -p npm install --save-exact $argv
end
