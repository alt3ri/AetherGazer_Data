function defaultValue(slot0, slot1)
	return slot0 == nil and slot1 or slot0
end

function isNil(slot0)
	return slot0 == nil or slot0:Equals(nil)
end

function extend(slot0, slot1)
	if slot0 then
		for slot5, slot6 in pairs(slot1) do
			if slot0[slot5] == nil then
				slot0[slot5] = slot6
			end
		end
	end

	return slot0
end

function string.isNullOrEmpty(slot0)
	return slot0 == nil or string.len(slot0) == 0
end

function delS(slot0)
	if string.match(slot0, "%s*(.-)%s*$") == "" then
		return false
	else
		return true
	end
end

function seq(slot0)
	for slot5 = 1, slot0 do
	end

	return {
		[slot5] = slot5
	}
end

function swap(slot0, slot1, slot2)
	slot0[slot1] = slot0[slot2]
	slot0[slot2] = slot0[slot1]
end

function randomMN(slot0, slot1)
	slot2 = {}
	slot3 = nil

	if type(slot0) == "table" then
		slot3 = slot0
	elseif type(slot0) == "number" then
		slot3 = seq(slot0)
	end

	slot4 = #slot3

	for slot8 = 1, slot1 do
		slot9 = math.random(slot4)
		slot2[slot8] = slot3[slot9]

		swap(slot3, slot9, slot4)

		slot4 = slot4 - 1
	end

	return slot2
end

function parsedData(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(string.split(slot0, ";")) do
		table.insert(slot2, string.split(slot7, ","))
	end

	return slot2
end

function keyPairsSort(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		if type(slot5) == "number" then
			table.insert(slot1, slot5)
		end
	end

	table.sort(slot1)

	return slot1
end

function buildVector3(slot0)
	return Vector3(slot0[1], slot0[2], slot0[3])
end
