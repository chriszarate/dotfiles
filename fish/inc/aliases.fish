function a -d 'Ag with additional ignores and custom paging'
	ag --ignore={build,build-directory,dist,node_modules,vendor} --ignore='*[-.]min[-.]*' --ignore=bundle.js --ignore='*.json' --pager='less -R' -W 400 $argv
end

function cat -d 'Use bat instead of cat'
	bat $argv
end

function d -d 'Jump to a directory in the documents folder'
	cd ~/Documents
	fzf-cd-widget
end

function icat -d 'Display images in the terminal with kitty'
	kitty +kitten icat $argv
end

function l -d 'Show all files in a friendly way'
	exa -halF $argv
end

function ls -d 'Use exa instead of ls'
	exa $argv
end

function ping -d 'Use prettyping instead of ping'
	prettyping --nolegend $argv
end

function today -d 'Show calendar events for later today'
	icalBuddy -f -n eventsToday
end

function top -d 'Use htop instead of top'
	sudo htop $argv
end
