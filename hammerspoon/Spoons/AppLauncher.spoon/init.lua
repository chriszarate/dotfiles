--- === AppLauncher ===
---
--- Launch applications with a single keypress.
---
--- Prior art / adapted from:
--- https://www.reddit.com/r/hammerspoon/comments/smip1i/switchlaunch_apps_with_custom_shortcut/

-- luacheck: globals hs

local obj = {}

-- Metadata
obj.name = 'AppLauncher'
obj.version = '1.0'
obj.author = 'Chris Zarate <chris@zarate.org>'
obj.homepage = 'https://github.com/chriszarate/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

function obj:launch(name)
	hs.application.launchOrFocus(name)
end

--- AppLauncher:start(config)
--- Method
--- Start the spoon
---
--- Parameters:
---  * config - A table containing config values:
---             mappings: A table containing keys and apps to launch
---             timeout: A number of seconds to wait for a keypress before exiting the modal state
---
--- Returns:
---  * self (allow chaining)
function obj:start(config)
	local mappings = config.mappings or {}
	local modalMappings = config.modalMappings or {}

	for _, mapping in ipairs(modalMappings) do
		local name = mapping.name or 'Launcher'
		local timeout = mapping.timeout or 3
		local modal
		local timer

		local function cancel()
			if timer:running() then
				timer:stop()
			end

			modal:exit()
		end

		timer = hs.timer.delayed.new(timeout, cancel)
		modal = hs.hotkey.modal.new(mapping.modifier, mapping.key, name)

		function modal:entered()
			timer:start()
		end

		for key, app in pairs(mapping.map) do
			modal:bind({}, key, function()
				cancel()
				obj:launch(app)
			end)
		end

		modal:bind({}, 'ESCAPE', cancel)
	end


	for _, mapping in ipairs(mappings) do
		hs.hotkey.bind(mapping.modifier, mapping.key, nil, function()
			obj:launch(mapping.app)
		end)
	end

	return self
end

--- AppLauncher:stop()
--- Method
--- Stop the spoon
---
--- Parameters: none
---
--- Returns:
---  * self (allow chaining)
function obj:stop()
	return self
end

return obj
