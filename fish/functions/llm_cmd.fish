function llm_cmd -d 'Query the local LLM for a command based on the current command line input'
	set -l server_port 4040

	# 1. Get the text currently typed into the command line buffer
	set -l user_prompt (commandline -b)

	# Do nothing if the buffer is empty
	if test -z "$user_prompt"
		return
	end

	# Ensure the local model server is up before we query it. This is a no-op
	# (fast health check) when it's already running, but will spin it up and
	# block until ready on the first invocation.
	if not llm_server --quiet
		commandline -r "$user_prompt # (Error: could not start local model server)"
		commandline -f repaint
		return
	end

	# 2. Provide visual feedback that the AI is thinking.
	# fish only repaints the command line after a binding returns, so a
	# `commandline`-based message never renders during the blocking curl below.
	# Instead, write an inline spinner straight to the terminal: save the cursor
	# (ESC 7), append the message after the buffer, then restore (ESC 8).
	printf '\0337\033[2m # Fetching command...\033[0m\0338' >/dev/tty

	# 3. Payload for the llama.cpp server (OpenAI-compatible endpoint)
	set -l json_payload (jq -n --arg prompt "$user_prompt" '{
		model: "gemma",
		messages: [
		{role: "system", content: "You are a CLI assistant. Output ONLY the raw, executable shell command requested by the user. Absolutely no markdown, no triple backticks, no explanations, and no preamble."},
		{role: "user", content: $prompt}
		],
		temperature: 0.1
	}')

	# 4. Call the local model
	set -l response (curl -s -X POST "http://localhost:$server_port/v1/chat/completions" \
		-H "Content-Type: application/json" \
		-d "$json_payload")

	# 5. Erase the inline spinner (clear from cursor to end of screen) before we
	# hand the command line back to fish.
	printf '\033[J' >/dev/tty

	# Extract and clean the output
	set -l generated_cmd (echo "$response" | jq -r '.choices[0].message.content' | string trim)

	# Sanity check: Strip markdown code blocks if the LLM hallucinated them anyway
	set generated_cmd (string replace -r '^```[a-zA-Z]*\s*' '' -- "$generated_cmd")
	set generated_cmd (string replace -r '\s*```$' '' -- "$generated_cmd")

	# 6. Safety fallback if the API fails or returns null
	if test -z "$generated_cmd" -o "$generated_cmd" = "null"
		commandline -r "$user_prompt # (Error: Local model failed to respond)"
		commandline -f repaint
		return
	end

	# 7. Replace the buffer text with the AI's command (without executing it)
	commandline -r "$generated_cmd"

	# In vi mode, drop into insert mode so the command is ready to edit/run
	if set -q fish_bind_mode
		set fish_bind_mode insert
		commandline -f repaint-mode
	else
		commandline -f repaint
	end
end
