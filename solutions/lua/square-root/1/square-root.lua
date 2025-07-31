local SquareRoot = {}

function SquareRoot.square_root(radicand)
	local l = 0

	while (l + 1) * (l + 1) <= radicand do
		l = l + 1
	end

	return l
end

return SquareRoot
