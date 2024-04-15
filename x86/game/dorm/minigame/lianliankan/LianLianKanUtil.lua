slot0 = {}
slot1, slot2 = pcall(require, "bit")

if not slot1 then
	slot1, slot2 = pcall(require, "bit32")
end

slot3 = {
	down = -2,
	up = 2,
	left = -1,
	right = 1
}
slot4 = {
	[slot3.left] = Vector2.left,
	[slot3.right] = Vector2.right,
	[slot3.down] = Vector2.down,
	[slot3.up] = Vector2.up
}

function slot5(slot0, slot1)
	return slot0 and slot1 and slot0 + slot1 == 0
end

function slot6(slot0, slot1)
	return slot0 and slot1 and slot0 ~= slot1
end

function slot7(slot0, slot1, slot2)
	if slot0:IsGridEmpty(slot1, slot2) then
		return true
	end

	return slot0:Get(slot1, slot2) and slot3.isPlaceholder or false
end

function slot8(slot0, slot1, slot2, slot3, slot4)
	if slot4 == uv0.left then
		if slot0 < slot2 or slot1 ~= slot3 then
			return false
		end
	elseif slot4 == uv0.right then
		if slot2 < slot0 or slot1 ~= slot3 then
			return false
		end
	elseif slot4 == uv0.down then
		if slot1 < slot3 or slot0 ~= slot2 then
			return false
		end
	elseif slot4 == uv0.up and (slot3 < slot1 or slot0 ~= slot2) then
		return false
	end

	return true
end

function slot9(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot5 == nil then
		for slot9, slot10 in ipairs(uv0) do
			if uv1(slot1, slot2, slot3, slot4, slot5) and uv2(slot0, slot1, slot2, slot3, slot4, slot10) then
				return true
			end
		end
	else
		slot6 = uv3[slot5]
		slot8 = slot2 + slot6.y

		if slot1 + slot6.x == slot3 and slot8 == slot4 then
			return true
		end

		while uv4(slot0, slot7, slot8) do
			if slot7 + slot6.x == slot3 and slot8 + slot6.y == slot4 then
				return true
			end
		end
	end

	return false
end

function slot10(slot0, slot1, slot2)
	table.insert(slot0, Vector2(slot1, slot2))

	return slot0
end

function slot11(slot0, slot1, slot2, slot3, slot4)
	slot5 = {}

	for slot9, slot10 in pairs(uv0) do
		if not uv1(slot10, slot0) and slot10 ~= slot0 then
			table.insert(slot5, slot10)
		end
	end

	slot6 = Vector2(slot3 - slot1, slot4 - slot2)

	CommonTools.UniversalSortEx(slot5, {
		map = function (slot0)
			return Vector2.Dot(uv0[slot0], uv1)
		end
	})

	return ipairs(slot5)
end

function slot12(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if uv0(slot1, slot2, slot3, slot4, slot6) and uv1(slot0, slot1, slot2, slot3, slot4, slot6) then
		return {}
	end

	if slot5 == 0 then
		return nil
	end

	slot8 = uv2[slot6]
	slot9 = slot1 + slot8.x
	slot10 = slot2 + slot8.y

	while uv3(slot0, slot9, slot10) do
		slot14 = slot2
		slot15 = slot3

		for slot14, slot15 in uv4(slot6, slot1, slot14, slot15, slot4) do
			if uv5(slot0, slot9, slot10, slot3, slot4, slot5 - 1, slot15, slot7) then
				return uv6(slot16, slot9, slot10)
			end
		end

		slot10 = slot10 + slot8.y
		slot9 = slot9 + slot8.x
	end

	if slot9 == slot3 and slot10 == slot4 then
		return {
			Vector2(slot1, slot2)
		}
	end
end

function slot0.TestConnectivity(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == slot3 and slot2 == slot4 then
		return nil
	else
		slot10 = slot4
		slot11 = slot1

		for slot10, slot11 in uv0(nil, slot3, slot10, slot11, slot2) do
			if uv1(slot0, slot3, slot4, slot1, slot2, slot5, slot11, {}) then
				return slot12
			end
		end
	end
end

return slot0
