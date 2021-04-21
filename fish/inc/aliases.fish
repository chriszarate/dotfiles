function brundle -d "Install Homebrew packages using Brewfile"
	brew bundle --file="~/.dotfiles/brew/Brewfile"
end

function cat -d 'Use bat instead of cat'
	bat $argv
end

function code -d 'Alias VSCodium to VSCode shell command'
	codium $argv
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

function top -d 'Use htop instead of top'
	htop $argv
end
