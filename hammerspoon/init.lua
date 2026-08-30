-- luacheck: globals hs spoon

-- Private settings are optional. Keep errors visible when the file exists, but
-- let a fresh checkout start without it.
local config = {}
if hs.fs.attributes(hs.configdir .. '/config.lua') then
	config = require 'config'
end

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
					f = 'Finder.app',
					g = 'https://gemini.google.com/app',
					h = 'Hammerspoon.app',
					i = 'iA Writer.app',
					m = 'Messages.app',
					n = 'Numi.app',
					o = 'Orca.app',
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

if config.slackWorkspaces and #config.slackWorkspaces > 0 then
	spoons.SlackNotifier = {
		workspaces = config.slackWorkspaces,
	}
end

-- load spoons
for spoonName, spoonConfig in pairs(spoons) do
	hs.loadSpoon(spoonName)
	spoon[spoonName]:start(spoonConfig)
end
