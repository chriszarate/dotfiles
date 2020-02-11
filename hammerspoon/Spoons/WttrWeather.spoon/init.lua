-- menubar: local weather from wttr.in
-- luacheck: globals hs

local obj = {}

-- Metadata
obj.name = 'WttrWeather'
obj.version = '1.0'
obj.author = 'Chris Zarate <chris@zarate.org>'
obj.homepage = 'https://github.com/chriszarate/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

-- on click, open a useful url
local function onClick()
	hs.task.new('/usr/bin/open', nil, {obj.clickUrl}):start()
end

-- process the response
local function onResponse(status, body)
	if status < 0 then
		return
	end

	-- be a little particular about formatting
	local weather = body:gsub('[%s+]+', ' '):gsub('%s$', ''):gsub('°F', '°'):lower()

	-- update the menu bar
	obj.menu:setTitle(weather)
end

-- timer callback, fetch the response
local function onInterval()
	hs.http.asyncGet(obj.fetchUrl, nil, onResponse)
end

-- URL-encode string (for format string)
local function urlencode(str)
	local output, _ = string.gsub(str, "[^%w]", function(chr)
		return string.format("%%%X", string.byte(chr))
	end)

	return output
end

--- WttrWeather:start(config)
--- Method
--- Start the spoon
---
--- Parameters:
---  * config - A table containing config values:
--              clickUrl: URL to open on click (default: Open Weather)
--              format:   Wttr.in format string (defaul "%C+%t")
--              interval: Interval in seconds to refresh the menu (default 600)
---
--- Returns:
---  * self (allow chaining)
function obj:start(config)
	local format = config.format or '%C+%t'
	local interval = config.interval or 600

	self.clickUrl = config.clickUrl or 'https://openweathermap.org'
	self.fetchUrl = 'https://wttr.in/?format=' .. urlencode(format)

	-- create menubar
	self.menu = hs.menubar.new():setClickCallback(onClick):setTitle('loading...')

	-- set timer to fetch periodically
	self.timer = hs.timer.new(interval, onInterval)
	self.timer:start()

	-- fetch immediately, too
	onInterval()

	return self
end

--- WttrWeather:stop()
--- Method
--- Stop the spoon
---
--- Parameters: none
---
--- Returns:
---  * self (allow chaining)
function obj:stop()
	self.menu:removeFromMenuBar()
	self.timer:stop()

	return self
end

return obj
