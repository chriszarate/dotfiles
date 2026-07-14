function llm_server -d 'Start the local llama.cpp server if it is not already running'
	argparse q/quiet -- $argv
	or return 1

	set -l server_port 4040
	set -l models_preset "$HOME/.dotfiles/agents/models.conf"

	# Status messages go through this so --quiet can silence them. Errors still
	# print straight to stderr regardless.
	function __llm_server_say --inherit-variable _flag_quiet
		set -q _flag_quiet; and return
		echo $argv
	end

	# `llm_server stop` tears down the running server (and its router children).
	if test "$argv[1]" = stop
		if pkill -f llama-server
			__llm_server_say "🛑 Stopped llama-server."
			return 0
		else
			__llm_server_say "ℹ️  No llama-server process was running."
			return 0
		end
	end

	# Bail early if the server already answers its health endpoint.
	if curl -s -o /dev/null -m 1 "http://localhost:$server_port/health"
		__llm_server_say "✅ llama-server already running on port $server_port"
		return 0
	end

	if not test -f "$models_preset"
		echo "❌ Models preset not found: $models_preset" >&2
		return 1
	end

	__llm_server_say "🚀 Launching llama-server (router mode) in the background..."
	# Detach fully so the server outlives this shell; discard its chatter.
	# Model-specific flags live in the preset; requests select a model by name.
	llama-server \
		--models-preset "$models_preset" \
		--port $server_port >/dev/null 2>&1 &
	disown

	# Poll the health endpoint until the model has loaded into VRAM.
	__llm_server_say "⏳ Waiting for model to load into VRAM..."
	for i in (seq 60)
		if curl -s -o /dev/null -m 1 "http://localhost:$server_port/health"
			__llm_server_say "✅ llama-server is healthy and ready!"
			return 0
		end
		sleep 1
	end

	echo "❌ Server failed to respond within 60 seconds." >&2
	return 1
end
