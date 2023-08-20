-- luacheck: globals hs spoon

-- load config
local config = require 'config'

-- define spoons and config, which will be passed to :start
local spoons = {
	ControlEscMap = {
		timeout = 0.2,
	},
	HoldToQuit = {},
	SlackNotifier = {
		cookieToken = config.slackCookieToken,
		workspaceToken = config.slackWorkspaceToken,
	},
}

-- load spoons
for spoonName, spoonConfig in pairs(spoons) do
	hs.loadSpoon(spoonName)
	spoon[spoonName]:start(spoonConfig)
end
