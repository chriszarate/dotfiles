--- === SlackNotifier ===
---
--- Check Slack API periodically and provide a count of unread DMs and mentions
--- in a menubar app. This spoon requires a Slack legacy app token to be
--- provided to the :start method:
---
--- https://api.slack.com/legacy/custom-integrations/legacy-tokens

-- luacheck: globals hs

local obj = {}

-- Metadata
obj.name = 'SlackNotifier'
obj.version = '1.0'
obj.author = 'Chris Zarate <chris@zarate.org>'
obj.homepage = 'https://github.com/chriszarate/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

-- create the icon
-- http://xqt2.com/asciiIcons.html
local iconAscii = [[ASCII:
............
............
....AD......
..F.....PQ..
..I.........
..........G.
..........H.
.K..........
.N..........
.........L..
..BC.....M..
......SR....
............
............
]]

local icon = hs.image.imageFromASCII(iconAscii)

-- on click, open slack
local function onClick()
	hs.application.launchOrFocus('Slack')
end

-- update the menu bar
local function updateCount(count)
	if count > 0 then
		obj.menu:setTitle(count)
	else
		obj.menu:setTitle('')
	end
end

-- process the response
local function onResponse(status, body)
	if status < 0 then
		return
	end

	-- parse json response
	local json = hs.json.decode(body)
	local count = 0

	-- loop through channels and add up mention_count
	for _, channel in pairs(json.channels) do
		count = count + channel.mention_count
	end

	-- loop through dms and add up dm_count
	for _, dm in pairs(json.ims) do
		count = count + dm.dm_count
	end

	-- update the menu bar
	updateCount(count)
end

-- timer callback, fetch response
local function onInterval()
	hs.http.asyncGet(obj.fetchUrl, nil, onResponse)
end

--- SlackNotifier:start(config)
--- Method
--- Start the spoon
---
--- Parameters:
---  * config - A table containing config values:
--              interval: Interval in seconds to refresh the menu (default 60)
--              token:    Slack legacy API token (required)
---
--- Returns:
---  * self (allow chaining)
function obj:start(config)
	local interval = config.interval or 60

	-- https://api.slack.com/legacy/custom-integrations/legacy-tokens
	self.fetchUrl = 'https://slack.com/api/users.counts?token=' .. config.token

	-- create menubar (or restore it)
	if self.menu then
		self.menu:returnToMenuBar()
	else
		self.menu = hs.menubar.new():setClickCallback(onClick):setIcon(icon)
	end

	-- set timer to fetch periodically
	self.timer = hs.timer.new(interval, onInterval)
	self.timer:start()

	-- fetch immediately, too
	updateCount(0)
	onInterval()

	return self
end

--- SlackNotifier:stop()
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
