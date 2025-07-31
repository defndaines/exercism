local BottleSong = {}

local verse = [[
BEFORE hanging on the wall,
BEFORE hanging on the wall,
And if one green bottle should accidentally fall,
There'll be AFTER hanging on the wall.
]]

local numbers = { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "Ten" }

local function bottles(n)
	if n == 1 then
		return "one green bottle"
	elseif n == 0 then
		return "no green bottles"
	else
		return numbers[n] .. " green bottles"
	end
end

function BottleSong.recite(start_bottles, take_down)
	local song = {}

	for i = start_bottles, start_bottles - take_down + 1, -1 do
		local before = bottles(i):gsub("^%l", string.upper)
		local after = bottles(i - 1)
		local this = verse:gsub("BEFORE", before):gsub("AFTER", after)
		table.insert(song, this)
	end

	return table.concat(song, "\n")
end

return BottleSong
