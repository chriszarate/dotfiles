function a -d 'Ag with additional ignores and custom paging'
	ag --ignore={build,build-directory,dist,node_modules,vendor} --ignore='*[-.]min[-.]*' --ignore=bundle.js --ignore='*.json' --pager='less -R' -W 400 $argv
end

function cat -d 'Use bat instead of cat'
	bat $argv
end

function j -d 'Jump to a directory in the current tree'
	fzf-cd-widget
end

function l -d 'List files in detail'
	ls -laF --color=always $argv
end

function ping -d 'Use prettyping instead of ping'
	prettyping --nolegend
end

function top -d 'Use htop instead of top'
	sudo htop
end
