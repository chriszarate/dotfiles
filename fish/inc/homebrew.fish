if [ (uname) = 'Linux' ]
	set -x HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
	set -x HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -x HOMEBREW_REPOSITORY "$HOMEBREW_PRFIX/Homebrew"
	set --universal fish_user_paths $fish_user_paths "$HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin"
end
