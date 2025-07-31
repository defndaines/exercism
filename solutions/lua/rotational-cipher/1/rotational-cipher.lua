return {
	rotate = function(input, key)
		local cypher = {}

		for i = 1, #input do
			local ch = input:byte(i)

			if ch >= 97 and ch <= 122 then
				cypher[i] = string.char(97 + ((ch - 97 + key) % 26))
			elseif ch >= 65 and ch <= 90 then
				cypher[i] = string.char(65 + ((ch - 65 + key) % 26))
			else
				cypher[i] = string.char(ch)
			end
		end

		return table.concat(cypher)
	end,
}
