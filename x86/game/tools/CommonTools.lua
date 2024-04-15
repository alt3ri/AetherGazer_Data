function slot1(slot0, slot1)
	return slot0 < slot1
end

function slot2(slot0)
	return slot0
end

return {
	UniversalSort = function (slot0, slot1, ...)
		slot2 = {
			...
		}

		return table.sort(slot0, function (slot0, slot1)
			for slot5, slot6 in ipairs(uv0) do
				if slot0[slot6] ~= slot1[slot6] then
					if uv1 then
						return slot0[slot6] < slot1[slot6]
					else
						return slot1[slot6] < slot0[slot6]
					end
				end
			end
		end)
	end,
	UniversalSortEx = function (slot0, ...)
		slot1 = {
			...
		}

		return table.sort(slot0, function (slot0, slot1)
			for slot5, slot6 in pairs(uv0) do
				slot7 = slot6.map or uv1

				if slot7(slot0) ~= slot7(slot1) then
					if slot6.ascend then
						return slot6.lessOp or uv2(slot8, slot9)
					else
						return slot11(slot9, slot8)
					end
				end
			end

			return false
		end)
	end,
	Convert2SamePosition = function (slot0, slot1)
		slot0.position = slot1.position
	end,
	GenerateItems = function (slot0, slot1, slot2, slot3, slot4, slot5)
		if not slot0.pool then
			slot0.pool = {}
		end

		slot6 = #slot0.pool
		slot7 = #slot1

		while slot2 > slot7 do
			if slot6 > 0 then
				slot8 = slot0.pool[slot6]

				slot8.transform_:SetParent(slot5)
				table.insert(slot1, slot8)
				table.remove(slot0.pool, slot6)

				slot6 = slot6 - 1
			else
				table.insert(slot1, slot3.New(Object.Instantiate(slot4, slot5)))
			end

			slot7 = slot7 + 1
		end

		while slot2 < slot7 do
			slot1[slot7].gameObject_:SetActive(false)
			table.insert(slot0.pool, slot1[slot7])
			table.remove(slot1, slot7)

			slot7 = slot7 - 1
		end

		for slot11 = 1, slot7 do
			slot1[slot11].gameObject_:SetActive(true)
		end
	end,
	SetCommonData = function (slot0, slot1, slot2)
		(slot2 or clone(ItemTemplateData)).number = nil

		for slot6, slot7 in pairs(slot1) do
			slot2[slot6] = slot7
		end

		slot0:SetData(slot2)
	end
}
