local grains = {}

function grains.square(n)
	if n == 64 then
		return 2.0 * (1 << n - 2)
	else
		return 1 << n - 1
	end
end

function grains.total()
	local sum = 0

	for n = 1, 64 do
		sum = sum + grains.square(n)
	end

	return sum
end

return grains
