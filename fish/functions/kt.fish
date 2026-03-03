function kt -d 'Open current directory in a new Kitty tab'
	kitty @ --to unix:/tmp/kitty-socket launch --type=tab --cwd=$PWD
	open -a kitty
end
