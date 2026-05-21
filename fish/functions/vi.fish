function vi -d 'Load vim with no config' --wraps nvim
	nvim -u NONE $argv
end
