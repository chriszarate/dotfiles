-- menubar: local weather from wttr.in
-- luacheck: globals hs

local module = {}

local clickUrl = 'https://openweathermap.org'
local fetchInterval = 600
local fetchUrl = 'https://wttr.in/?format=%25C+%25t+%25m' -- url-encoded

-- on click, open a useful url
local function onClick()
	local task = hs.task.new('/usr/bin/open', nil, {clickUrl})
  task:start()
end

-- process the response
local function onResponse(status, body)
	if status < 0 then
		return
	end

	-- be a little particular about formatting
	local weather = body:gsub('[%s+]+', ' '):gsub('%s$', ''):gsub('°F', '°'):lower()

	-- update the menu bar
	module.menu:setTitle(weather)
end

-- timer callback, fetch the response
local function onInterval()
	hs.http.asyncGet(fetchUrl, nil, onResponse)
end

-- create menubar
module.menu = hs.menubar.new():setClickCallback(onClick):setTitle('loading...')

-- set timer to fetch periodically
module.timer = hs.timer.new(fetchInterval, onInterval)
module.timer:start()

-- fetch immediately, too
onInterval()

return module
