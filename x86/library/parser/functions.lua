function slot0(slot0, slot1)
	return (slot0.x - slot1.x) * (slot0.x - slot1.x) + (slot0.y - slot1.y) * (slot0.y - slot1.y) + (slot0.z - slot1.z) * (slot0.z - slot1.z)
end

return {
	inc = function (slot0)
		return slot0 + 1
	end,
	dec = function (slot0)
		return slot0 - 1
	end,
	sum = function (...)
		for slot5 = 1, #{
			...
		} do
			slot0 = 0 + slot1[slot5]
		end

		return slot0
	end,
	dist = function (slot0, slot1)
		return math.sqrt(uv0(slot0, slot1))
	end,
	count = function (slot0)
		return #slot0
	end,
	index = function (slot0, slot1)
		return slot0[slot1]
	end,
	pointAtCircle = function (slot0, slot1, slot2)
		slot3 = Vector3.Normalize(Vector3.New(slot0.x - slot1.x, slot0.y - slot1.y, slot0.z - slot1.z))

		slot3:Mul(slot2)
		slot3:Add(slot1)

		return slot3
	end,
	radians4point2d = function (slot0, slot1, slot2, slot3)
		return lk.math2d.radians4point(slot0, slot1, slot2, slot3)
	end,
	radians2degrees = function (slot0)
		return lk.math2d.radians2degrees(slot0)
	end,
	kvPair = function (slot0, slot1)
		return {
			[slot0] = slot1
		}
	end,
	["and"] = function (...)
		for slot4 = 1, #{
			...
		} do
			if not slot0[slot4] then
				return false
			end
		end

		return true
	end,
	["or"] = function (...)
		for slot4 = 1, #{
			...
		} do
			if slot0[slot4] then
				return true
			end
		end

		return false
	end,
	["not"] = function (slot0)
		return not slot0
	end,
	["if"] = function (slot0, slot1, slot2)
		if slot0 then
			return slot1
		else
			return slot2
		end
	end
}
