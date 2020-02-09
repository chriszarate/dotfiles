-- luacheck: globals hs hsmods

-- load config and expose on hs global
hs.config = require 'config'

-- load mofules
hsmods = {
	slack = require 'modules/slack',
	weather = require 'modules/weather'
}
