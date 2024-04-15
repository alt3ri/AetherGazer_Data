slot0 = class("LianLianKanItemGen")

function slot0.Ctor(slot0, slot1, slot2)
	slot0.weights = {}
	slot0.total = slot1
	slot0.offset = 0

	for slot7, slot8 in ipairs(slot2) do
		slot3 = 0 + slot8[2]
		slot0.weights[slot8[1]] = slot1 * slot8[2]
	end

	for slot7, slot8 in pairs(slot0.weights) do
		slot0.weights[slot7] = slot8 / slot3
	end
end

function slot1(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0) do
		if slot8 > 0 and math.random() * (slot1 + slot2) - slot8 < 0 then
			return slot7
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot0) do
		table.insert(slot4, slot8)
	end

	return slot4[math.random(#slot4)]
end

function slot0.Take(slot0, slot1)
	slot2 = uv0(slot0.weights, slot0.total, slot0.offset)
	slot3 = slot0.weights[slot2]

	slot0:Pop(slot2, slot1)

	return slot2
end

function slot0.Peek(slot0, slot1, slot2)
	slot3 = clone(slot0.weights)
	slot4 = slot0.total
	slot5 = slot0.offset
	slot6 = {}

	for slot10 = 1, slot1 do
		slot11 = uv0(slot3, slot4, slot5)
		slot4 = slot4 - slot2
		slot3[slot11] = slot3[slot11] - slot2

		if slot3[slot11] < 0 then
			slot5 = slot5 - slot3[slot11]
		end

		table.insert(slot6, slot11)
	end

	return slot6
end

function slot0.Pop(slot0, slot1, slot2)
	slot0.total = slot0.total - slot2
	slot3 = slot0.weights[slot1] - slot2
	slot0.weights[slot1] = slot3

	if slot3 < 0 then
		slot0.offset = slot0.offset + math.min(-slot3, slot2)
	end
end

function slot0.Return(slot0, slot1, slot2)
	slot3 = slot0.weights[slot1]
	slot0.weights[slot1] = slot3 + slot2
	slot0.total = slot0.total + slot2

	if slot3 < 0 then
		slot0.offset = slot0.offset - math.min(-slot3, slot2)
	end
end

return slot0
