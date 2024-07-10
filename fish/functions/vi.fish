function vi -d 'Load vim with no config' --wraps vim
	vim -u NONE $argv
end
