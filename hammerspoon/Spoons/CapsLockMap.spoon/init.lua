--- === CapsLockMap ===
---
--- Map caps lock to both Esc and Control -- tap for Esc, hold for Control.
---
--- Prior art / adapted from:
--- https://gist.github.com/zcmarine/f65182fe26b029900792fa0b59f09d7f
--- https://gist.github.com/arbelt/b91e1f38a0880afb316dd5b5732759f1
--- https://github.com/jasoncodes/dotfiles/blob/master/hammerspoon/control_escape.lua

-- luacheck: globals hs

local obj = {}

-- Metadata
obj.name = 'CapsLockMap'
obj.version = '1.0'
obj.author = 'Chris Zarate <chris@zarate.org>'
obj.homepage = 'https://github.com/chriszarate/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

-- State
local state = {
	prev_mod = {},
	send_esc = false,
	timer = nil,
}

local function handler(evt)
	local new_mod = evt:getFlags()

	if state.prev_mod["ctrl"] == new_mod["ctrl"] then
		return false
	end

	if not state.prev_mod["ctrl"] then
		state.prev_mod = new_mod
		state.send_esc = true
		state.timer:start()
	else
		if state.send_esc then
			hs.eventtap.keyStroke({}, "ESCAPE")
		end

		state.prev_mod = new_mod
		state.timer:stop()
	end

	return false
end

local function reset()
  state.send_esc = false
  return false
end

--- CapsLockMap:start(config)
--- Method
--- Start the spoon
---
--- Parameters:
---  * config - A table containing config values:
--              timeout: Maximum press that will be considered a tap (default 0.2)
---
--- Returns:
---  * self (allow chaining)
function obj:start(config)
	local timeout = config.timeout or 0.2
	state.timer = hs.timer.delayed.new(timeout, reset)

	self.event_on = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, handler)
	self.event_on:start()

	self.event_off = hs.eventtap.new({hs.eventtap.event.types.keyDown}, reset)
	self.event_off:start()

	return self
end

--- CapsLockMap:stop()
--- Method
--- Stop the spoon
---
--- Parameters: none
---
--- Returns:
---  * self (allow chaining)
function obj:stop()
	self.event_on:stop()
	self.event_off:stop()

	return self
end

return obj
