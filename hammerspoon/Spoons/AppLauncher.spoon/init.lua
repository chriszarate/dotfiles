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
	-- Check if name is a URL (starts with a URL scheme)
	local isURL = name:match("^https?://") or name:match("^file://")

	if isURL then
		local browserName = "Safari" -- Change this to your preferred browser if needed
		local browserRunning = false

		local app = hs.application.find(browserName)
		if app and app:isRunning() then
			browserRunning = true
		end

		if browserRunning then
			-- Open URL in the running browser (adds new tab)
			local script = string.format([[
				tell application "%s"
					activate

					if (count of windows) is 0 then
							make new document
					end if

					-- Open a new tab in the frontmost window
					tell window 1
							set newTab to make new tab with properties {URL:"%s"}
							set current tab to newTab
					end tell
				end tell
			]], browserName, name)

			hs.osascript.applescript(script)
		else
			-- No browser running, use default
			hs.urlevent.openURL(name)
		end
	else
		hs.application.launchOrFocus(name)
	end
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
		local lines = {}
		local timeout = mapping.timeout or 3
		local modal
		local timer

		-- Format each key -> app pair
		for key, app in pairs(mapping.map) do
			table.insert(lines, key .. " → " .. app)
		end

		local content = table.concat(lines, "\n")

		modal = hs.hotkey.modal.new(mapping.modifier, mapping.key, nil)
		timer = hs.timer.delayed.new(timeout, modal.exit)

		function modal:entered()
			timer:start()
			hs.alert.show(content, {
				textFont = "Menlo",
				textSize = 14,
				fadeInDuration = 0.2,
				fadeOutDuration = 0.5,
				padding = 20,
			}, timeout)
		end

		function modal:exited()
			hs.alert.closeAll()

			if timer:running() then
				timer:stop()
			end
		end

		for key, app in pairs(mapping.map) do
			modal:bind({}, key, function()
				modal:exit()
				obj:launch(app)
			end)
		end

		modal:bind({}, 'ESCAPE', modal.exit)
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
