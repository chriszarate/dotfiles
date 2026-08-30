function env_run -d 'Source a file of environment variables and run a program with those variables exposed'
	if test (count $argv) -lt 2
		echo "usage: env_run <environment-file> <command> [arguments...]" >&2
		return 2
	end

	# Run in a subprocess so sourced values do not leak into the current shell.
	# Bash handles quotes, spaces, and additional equals signs in assignments.
	command bash -c 'set -a; source "$1"; shift; exec "$@"' env_run $argv
end
