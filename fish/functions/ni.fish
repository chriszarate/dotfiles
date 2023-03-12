function ni --wraps=npm -d 'npm install with --save-exact'
	npm i --save-exact $argv
end
