return function(n)
	local rain = { [3] = "Pling", [5] = "Plang", [7] = "Plong" }

	local result = {}

	for _, modulus in ipairs({ 3, 5, 7 }) do
		if n % modulus == 0 then
			result[#result + 1] = rain[modulus]
		end
	end

	local string = table.concat(result)

	if string == "" then
		return tostring(n)
	else
		return string
	end
end
