local SquareRoot = {}

function SquareRoot.square_root(radicand)
	local step = function(n)
		return (n + radicand / n) / 2
	end

	local x0 = radicand / 2
	local x1 = step(x0)

	while x1 < x0 do
		x0 = x1
		x1 = step(x0)
	end

	return math.floor(x0 + 0.5)
end

return SquareRoot
