function rgs --wraps=rg -d 'Search with ripgrep, skipping tests, mocks, and fixtures'
	# ~/.rgignore-tests is not a name ripgrep looks for on its own, so it only
	# takes effect when named here. Keeping it out of ~/.rgignore means plain
	# `rg` still finds test files, which is usually what you want.
	rg --ignore-file "$HOME/.rgignore-tests" $argv
end
