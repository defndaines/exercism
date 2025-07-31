local a = ("a"):byte()
local z = ("z"):byte()

return {
	encode = function(plaintext)
		local encoded = {}

		plaintext:lower():gsub("%w", function(ch)
			local byte = ch:byte()

			if byte >= a and byte <= z then
				table.insert(encoded, string.char(a + z - byte))
			else
				table.insert(encoded, ch)
			end
		end)

		local chunks = {}

		for i = 6, #encoded, 5 do
			table.insert(chunks, #chunks + 1, i)
		end

		for i = #chunks, 1, -1 do
			table.insert(encoded, chunks[i], " ")
		end

		return table.concat(encoded)
	end,
}
