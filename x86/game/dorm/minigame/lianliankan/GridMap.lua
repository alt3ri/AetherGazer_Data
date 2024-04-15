slot0 = class("GridMap")
slot1 = 1

function slot0.Ctor(slot0, slot1, slot2)
	slot0.map = {}
	slot0.width = slot1
	slot0.height = slot2
	slot0.available = {}

	for slot6 = 0, slot1 - 1 do
		for slot10 = 0, slot2 - 1 do
			table.insert(slot0.available, slot0:ToIdx(slot6, slot10))
		end
	end
end

function slot0.ToIdx(slot0, slot1, slot2)
	if slot1 < 0 or slot0.width <= slot1 or slot2 < 0 or slot0.height <= slot2 then
		return nil
	end

	return (slot2 + uv0) * (slot0.width + 2 * uv0) + slot1 + uv0
end

function slot0.ToCoord(slot0, slot1)
	return slot1 % (slot0.width + 2 * uv0) - uv0, math.floor(slot1 / (slot0.width + 2 * uv0)) - uv0
end

function slot0.Get(slot0, slot1, slot2)
	return nullable(slot0.map, slot0:ToIdx(slot1, slot2))
end

function slot0.IsGridInMap(slot0, slot1, slot2)
	return slot1 >= 0 and slot1 < slot0.width and slot2 >= 0 and slot2 < slot0.height
end

function slot0.IsGridEmpty(slot0, slot1, slot2)
	return slot0:Get(slot1, slot2) == nil and slot1 >= -1 and slot1 <= slot0.width and slot2 >= -1 and slot2 <= slot0.height
end

function slot0.HasGridEmpty(slot0, slot1)
	if slot1 > #slot0.available then
		return nil
	end

	return unpack(slot0.available, 1, slot1)
end

function slot0.Put(slot0, slot1, slot2, slot3)
	if slot0:ToIdx(slot1, slot2) then
		if slot0.map[slot4] == nil and slot3 ~= nil then
			table.removebyvalue(slot0.available, slot4)
		elseif slot5 ~= nil and slot3 == nil then
			table.insert(slot0.available, slot4)
		end

		slot0.map[slot4] = slot3
	end

	return slot4
end

function slot0.RndPut(slot0, slot1)
	if next(slot0.available) == nil then
		return nil
	end

	slot2 = math.random(#slot0.available)
	slot0.available[slot2] = slot0.available[#slot0.available]
	slot0.available[#slot0.available] = slot0.available[slot2]
	slot3 = table.remove(slot0.available)
	slot0.map[slot3] = slot1

	return slot3
end

function slot0.RemoveByIdx(slot0, slot1)
	if slot0.map[slot1] ~= nil then
		table.insert(slot0.available, slot1)

		slot0.map[slot1] = nil
	end
end

return slot0
