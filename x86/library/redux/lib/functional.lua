function head(slot0)
	return slot0[1]
end

function tail(slot0)
	if table.getn(slot0) < 1 then
		return nil
	else
		slot1 = {}
		slot3 = 2

		while table.getn(slot0) >= slot3 do
			table.insert(slot1, slot3 - 1, slot0[slot3])

			slot3 = slot3 + 1
		end

		return slot1
	end
end

function foldr(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot2) do
		slot1 = slot0(slot1, slot7)
	end

	return slot1
end

function reduce(slot0, slot1)
	return foldr(slot0, head(slot1), tail(slot1))
end

function map(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot0(slot7))
	end

	return slot2
end
