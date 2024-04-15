function slot0(slot0, slot1)
	return slot0 == slot1
end

function slot1(slot0, slot1, slot2)
	if slot1 == nil or slot2 == nil or #slot1 ~= #slot2 then
		return false
	end

	for slot6, slot7 in ipairs(slot1) do
		if not slot0(slot7, slot2[slot6]) then
			return false
		end
	end

	return true
end

function slot2(slot0, slot1)
	if slot1 == nil then
		slot1 = uv0
	end

	slot2, slot3 = nil

	return function (...)
		if not uv0(uv1, uv2, {
			...
		}) then
			uv3 = uv4(unpack(slot0))
		end

		uv2 = slot0

		return uv3
	end
end

function slot3(slot0)
	slot1 = nil
	slot2 = true

	for slot6, slot7 in ipairs((type(slot0[1]) ~= "table" or slot0[1]) and {
		unpack(slot0)
	}) do
		if type(slot7) ~= "function" then
			slot2 = false

			break
		end
	end

	if not slot2 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot1) do
			table.insert(slot3, type(slot8))
		end

		error(string.format("        Selector creators expect all input-selectors to be functions,\n        instead received the following types: [%s]", table.concat(slot3, ", ")))
	end

	return slot1
end

function slot4(slot0, ...)
	slot2 = {
		...
	}

	return function (...)
		slot0 = {
			...
		}
		slot1 = 0
		slot4 = uv1(function (...)
			uv0 = uv0 + 1

			return uv1(unpack({
				...
			}))
		end, unpack(uv2))

		return {
			compute = uv1(function (...)
				slot0 = {}

				for slot4, slot5 in ipairs(uv0) do
					table.insert(slot0, slot5(unpack({
						...
					})))
				end

				return uv1(unpack(slot0))
			end),
			resultFunc = table.remove(slot0),
			dependencies = uv0(slot0),
			recomputations = function ()
				return uv0
			end,
			resetRecomputations = function ()
				uv0 = 0
			end
		}
	end
end

return {
	defaultMemoize = slot2,
	createSelectorCreator = slot4,
	createSelector = slot4(slot2),
	createStructuredSelector = function (slot0, slot1)
		if slot1 == nil then
			slot1 = uv0
		end

		if type(slot0) ~= "table" then
			error(string.format("        createStructuredSelector expects first argument to be an object\n        where each property is a selecotr, instead received a %s", type(slot0)))
		end

		slot2 = {}

		for slot7, slot8 in pairs(slot0) do
			table.insert({}, slot7)
			table.insert(slot2, slot8)
		end

		return slot1(slot2, function (...)
			for slot4, slot5 in ipairs({
				...
			}) do
				-- Nothing
			end

			return {
				[uv0[slot4]] = slot5
			}
		end)
	end
}
