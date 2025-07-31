local SECONDS_IN_YEAR = 365.25 * 24 * 60 * 60

local PERIODS = {
	mercury = 0.2408467,
	venus = 0.61519726,
	earth = 1.0,
	mars = 1.8808158,
	jupiter = 11.862615,
	saturn = 29.447498,
	uranus = 84.016846,
	neptune = 164.79132,
}

local SpaceAge = {}

function SpaceAge.new(age, seconds)
	age.seconds = seconds

	for planet, period in pairs(PERIODS) do
		age["on_" .. planet] = function()
			return seconds / period / SECONDS_IN_YEAR
		end
	end

	return age
end

return SpaceAge
