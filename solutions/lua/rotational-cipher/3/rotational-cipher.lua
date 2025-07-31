local UPPER_A = ("A"):byte()
local LOWER_A = ("a"):byte()

return {
	rotate = function(input, key)
		return input:gsub("%a", function(ch)
			local byte = ch:byte()
			local offset = byte < LOWER_A and UPPER_A or LOWER_A
			return string.char(offset + ((byte - offset + key) % 26))
		end)
	end,
}
