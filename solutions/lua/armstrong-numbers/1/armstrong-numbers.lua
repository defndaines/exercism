local function todigits(n)
	local digits = {}

	while n > 0 do
		table.insert(digits, 1, n % 10)
		n = math.floor(n / 10)
	end

	return digits
end

local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
	local digits = todigits(number)
	local sum = 0

	for _, digit in ipairs(digits) do
		sum = sum + digit ^ #digits
	end

	return number == sum
end

return ArmstrongNumbers
