function ghe --wraps gh -d 'Run gh against github.a8c.com through the Autoproxxy proxy of this computer'
	HTTPS_PROXY=socks5://127.0.0.1:8080 GH_HOST=github.a8c.com command gh $argv
end
