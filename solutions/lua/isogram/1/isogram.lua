return function(s)
	s = s:lower()
	local letters = {}

	for i = 1, #s do
		local ch = s:sub(i, i)

		if letters[ch] then
			return false
		elseif ch:match("%l") then
			letters[ch] = true
		end
	end

	return true
end
