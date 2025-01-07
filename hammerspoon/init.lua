-- luacheck: globals hs spoon

-- load config
local config = require 'config'

-- define spoons and config, which will be passed to :start
local spoons = {
	AppLauncher = {
		mappings = {
			{
				app = 'Kitty.app',
				key = 'f3',
				modifier = 'shift',
			},
		},
		modalMappings = {
			{
				key = 'f3',
				map = {
					a = 'Autoproxxy.app',
					b = 'Boop.app',
					d = 'Dash.app',
					f = 'Finder.app',
					h = 'Hammerspoon.app',
					k = 'Slack.app',
					m = 'Messages.app',
					n = 'Numi.app',
					o = 'Obsidian.app',
					p = 'Passwords.app',
					s = 'Safari.app',
					t = 'Kitty.app',
				},
				modifier = nil,
				name = 'Launcher',
				timeout = 3,
			},
		},
	},
	ControlEscMap = {
		timeout = 0.2,
	},
	HoldToQuit = {},
	MiroWindowsManager = {
		animationDuration = 0,
		mappings = {
			hyper = {
				key = { 'ctrl', 'alt', 'cmd' },
				map = {
					up = 'up',
					right = 'right',
					down = 'down',
					left = 'left',
					fullscreen = 'return',
					nextscreen = 'n',
				},
			},
		},
	},
	TextClipboardHistory = {},
}

-- load spoons
for spoonName, spoonConfig in pairs(spoons) do
	hs.loadSpoon(spoonName)
	spoon[spoonName]:start(spoonConfig)
end
