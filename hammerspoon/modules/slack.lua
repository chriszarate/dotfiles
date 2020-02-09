-- menubar: slack dms / mentions count
-- luacheck: globals hs

local module = {}

local fetchInterval = 60

-- see ../config.example.lua
local fetchUrl = 'https://slack.com/api/users.counts?token=' .. hs.config.slackToken

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
		module.menu:setTitle(count)
	else
		module.menu:setTitle('')
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
	hs.http.asyncGet(fetchUrl, nil, onResponse)
end

-- create menubar
module.menu = hs.menubar.new():setClickCallback(onClick):setIcon(icon)

-- set timer to fetch periodically
module.timer = hs.timer.new(fetchInterval, onInterval)
module.timer:start()

-- fetch immediately, too
updateCount(0)
onInterval()

return module
