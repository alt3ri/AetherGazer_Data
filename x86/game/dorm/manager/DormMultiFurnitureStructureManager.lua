slot0 = singletonClass("DormMultiFurnitureStructureManager")
slot1 = import("..combineRule.rail")
slot2 = {
	[slot1.STATION] = slot1
}

function slot0.Init(slot0)
end

function slot0.Reset(slot0)
end

function slot3(slot0)
	return uv0[slot0]
end

function slot0.RefreshAllMultiFurnitureStructure(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if not slot2[slot7] and uv0(DormUtils.GetEntityData(slot7).cfgID) and slot10.Match(slot7, slot8.connect, slot2) then
			for slot15, slot16 in pairs(slot11) do
				slot2[slot16] = slot7
			end
		end
	end
end

return slot0
