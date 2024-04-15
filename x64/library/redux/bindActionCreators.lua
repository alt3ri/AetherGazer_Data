function slot0(slot0, slot1)
	return function (...)
		return uv0(uv1(unpack({
			...
		})))
	end
end

return function (slot0, slot1)
	if type(slot0) == "function" then
		return uv0(slot0, slot1)
	end

	if type(slot0) ~= "table" then
		error("        bindActionCreators expected a table or a function.")
	end

	for slot6, slot7 in pairs(slot0) do
		if type(slot7) == "function" then
			-- Nothing
		end
	end

	return {
		[slot6] = uv0(slot7, slot1)
	}
end
