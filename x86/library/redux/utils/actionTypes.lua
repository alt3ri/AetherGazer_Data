function slot0()
	slot0 = {}

	for slot4 = 1, 5 do
		if math.random(0, 35) < 10 then
			table.insert(slot0, string.char(slot5 + 48))
		else
			table.insert(slot0, string.char(slot5 - 10 + 65))
		end
	end

	return table.concat(slot0, ".")
end

return {
	INIT = string.format("@@redux/INIT%s", slot0()),
	REPLACE = string.format("@@redux/REPLACE%s", slot0()),
	PROBE_UNKNOWN_ACTION = function ()
		return string.format("@@redux/PROBE_UNKNOWN_ACTION%s", uv0())
	end
}
