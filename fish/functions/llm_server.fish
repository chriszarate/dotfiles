function llm_server -d 'Start the local llama.cpp server if it is not already running'
	argparse q/quiet -- $argv
	or return 1

	set -l server_port 4040
	set -l models_preset "$HOME/.dotfiles/agents/models.conf"
	# The model llm_cmd asks for. We wait on *this* model being loaded, not
	# just on the router answering, because the router reports itself healthy
	# even when the model behind it failed to load (bad path, out of memory).
	set -l model_name cmd

	# Status messages go through this so --quiet can silence them. Errors still
	# print straight to stderr regardless.
	function __llm_server_say --inherit-variable _flag_quiet
		set -q _flag_quiet; and return
		echo $argv
	end

	# Ask the router how the model is doing: "loaded", "unloaded", or empty if
	# the router isn't up yet.
	function __llm_model_status --inherit-variable server_port --inherit-variable model_name
		curl -s -m 2 "http://localhost:$server_port/v1/models" 2>/dev/null \
			| jq -r --arg m "$model_name" '.data[]? | select(.id == $m) | .status.value' 2>/dev/null
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

	# Bail early if the model is already loaded and ready to answer.
	if test "$(__llm_model_status)" = loaded
		__llm_server_say "✅ llama-server already running on port $server_port"
		return 0
	end

	if not test -f "$models_preset"
		echo "❌ Models preset not found: $models_preset" >&2
		return 1
	end

	# Start the router only if nothing is listening yet. It may already be up
	# with the model merely unloaded, in which case we just wait below.
	if not curl -s -o /dev/null -m 1 "http://localhost:$server_port/health"
		__llm_server_say "🚀 Launching llama-server (router mode) in the background..."
		# Detach fully so the server outlives this shell; discard its chatter.
		# Model-specific flags live in the preset; requests select a model by name.
		llama-server \
			--models-preset "$models_preset" \
			--port $server_port >/dev/null 2>&1 &
		disown
	end

	# Poll until the model itself reports loaded. A cold start has to read a
	# few GB off disk, so give it a couple of minutes.
	__llm_server_say "⏳ Waiting for model '$model_name' to load into memory..."
	for i in (seq 120)
		if test "$(__llm_model_status)" = loaded
			__llm_server_say "✅ llama-server is healthy and ready!"
			return 0
		end
		sleep 1
	end

	# Say what actually went wrong rather than just "timed out". The router
	# records the failing model's exit code and the command it tried to run.
	echo "❌ Model '$model_name' did not load within 120 seconds." >&2
	curl -s -m 2 "http://localhost:$server_port/v1/models" 2>/dev/null \
		| jq -r --arg m "$model_name" '.data[]? | select(.id == $m) | .status
			| if .failed then "   llama-server exited with code \(.exit_code). Check the model path in the preset." else "   Status: \(.value)" end' >&2
	return 1
end
