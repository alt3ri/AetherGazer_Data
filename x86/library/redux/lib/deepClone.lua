function deepClone(slot0)
	slot1 = {}

	return function (slot0)
		if type(slot0) ~= "table" then
			return slot0
		elseif uv0[slot0] then
			return uv0[slot0]
		end

		uv0[slot0] = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[uv1(slot5)] = uv1(slot6)
		end

		return setmetatable(slot1, getmetatable(slot0))
	end(slot0)
end
