function gpt -d 'Ask a question to ChatGPT'
	set -l model "gpt-3.5-turbo"
	set -l question (echo $argv | string join " ")

	curl https://api.openai.com/v1/chat/completions -s \
		-H "Content-Type: application/json" \
		-H "Authorization: Bearer $OPENAI_API_TOKEN" \
		-d '{"model": "'$model'", "messages": [{"role": "user", "content": "'$question'"}],"temperature": 0.7}' \
		| jq -r '.choices[0].message.content'
end
