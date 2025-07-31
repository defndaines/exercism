local SquareRoot = {}

function SquareRoot.square_root(radicand)
	local l = 0
	local a = 1
	local d = 3

	while a <= radicand do
		a = a + d
		d = d + 2
		l = l + 1
	end

	return l
end

return SquareRoot
