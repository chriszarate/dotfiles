function cat -d 'Use bat instead of cat'
	bat $argv
end

function d -d 'Jump to a directory in the current folder'
	fzf-cd-widget
end

function icat -d 'Display images in the terminal with kitty'
	kitty +kitten icat $argv
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

function tomorrow -d 'Show calendar events for tomorrow'
	icalBuddy -f eventsFrom:tomorrow to:tomorrow
end

function top -d 'Use htop instead of top'
	sudo htop $argv
end
