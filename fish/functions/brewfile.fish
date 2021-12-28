function brewfile -d 'Update Brewfile from currently installed packages'
	brew bundle dump --force
end
