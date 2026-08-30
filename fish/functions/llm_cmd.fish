function llm_cmd -d 'Query the local LLM for a command based on the current command line input'
	set -l server_port 4040
	set -l model_name cmd

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
	#
	# The system prompt names the platform and shell on purpose. Without it the
	# model reaches for GNU coreutils flags it learned from Linux examples
	# (`sed -i` with no argument, `find -printf`) which fail on macOS, and it
	# writes bash `export FOO=bar` instead of fish `set -x FOO bar`.
	#
	# `enable_thinking: false` matters for speed: Qwen3.5 reasons out loud by
	# default, which spends 10-30 seconds on visible scratch work before the
	# answer. Turning it off makes a one-line command come back in 1-2 seconds.
	#
	# `max_tokens` is a backstop so a confused model can't hang the keybinding
	# writing an essay.
	set -l system_prompt "You are a command-line assistant. The user is on macOS (BSD userland, not GNU) and uses the fish shell. Output ONLY the raw executable command. No markdown, no backticks, no explanation, no preamble.
macOS notes: sed in-place needs an empty argument, sed -i ''; find has no -printf; set fish variables with 'set -x NAME value'."

	set -l json_payload (jq -n \
		--arg model "$model_name" \
		--arg system "$system_prompt" \
		--arg prompt "$user_prompt" '{
		model: $model,
		messages: [
		{role: "system", content: $system},
		{role: "user", content: $prompt}
		],
		temperature: 0.1,
		max_tokens: 256,
		chat_template_kwargs: {enable_thinking: false}
	}')

	# 4. Call the local model
	set -l response (curl -s -X POST "http://localhost:$server_port/v1/chat/completions" \
		-H "Content-Type: application/json" \
		-d "$json_payload")

	# 5. Erase the inline spinner (clear from cursor to end of screen) before we
	# hand the command line back to fish.
	printf '\033[J' >/dev/tty

	# Extract and clean the output
	set -l generated_cmd (echo "$response" | jq -r '.choices[0].message.content // empty' | string trim | string collect)

	# Sanity check: strip markdown if the model wrapped the command anyway,
	# both fenced blocks and a single pair of inline backticks.
	set generated_cmd (string replace -r '^```[a-zA-Z]*\s*' '' -- "$generated_cmd")
	set generated_cmd (string replace -r '\s*```$' '' -- "$generated_cmd")
	set generated_cmd (string replace -r '^`(.*)`$' '$1' -- "$generated_cmd")
	set generated_cmd (string trim -- "$generated_cmd")

	# 6. Safety fallback if the API fails or returns nothing. Show the server's
	# own error when there is one — "model not found" and "out of memory" need
	# different fixes, and a generic message hides which one happened.
	if test -z "$generated_cmd"
		set -l err (echo "$response" | jq -r '.error.message // empty' 2>/dev/null | string trim | string collect)
		if test -z "$err"
			set err "no response from server"
		end
		commandline -r "$user_prompt # (Error: $err)"
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
