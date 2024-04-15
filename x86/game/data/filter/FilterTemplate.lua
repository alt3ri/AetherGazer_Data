slot0 = class("FilterTemplate")
slot1, slot2 = pcall(require, "bit")

if not slot1 then
	slot1, slot2 = pcall(require, "bit32")
end

function slot0.Ctor(slot0, slot1)
	slot0.filterId = slot1
	slot0.data = {}
end

function slot0.Clear(slot0)
	slot0.data = {}
end

function slot0.ClearGroup(slot0, slot1)
	if slot0.data[slot1] then
		slot0.data[slot1] = nil
	end
end

function slot0.IsAll(slot0, slot1)
	for slot5, slot6 in pairs(slot0.data) do
		if slot6 > 0 then
			return false
		end
	end

	return true
end

function slot0.LShiftOne(slot0, slot1)
	return uv0.lshift(1, slot1)
end

function slot0.HasFlag(slot0, slot1, slot2)
	slot4 = slot0:GetFilterData(slot1) or 0

	if CommonFilterConst.GetGroupCfg(slot1).mode == Filter_Group_Mode.SingleMode and slot4 == 0 and slot2 == 1 then
		return true
	end

	return uv0.band(slot4, slot2) ~= 0
end

function slot0.LessEqualFlag(slot0, slot1, slot2)
	return uv0.band(slot0:GetFilterData(slot1) or 0, slot2) == slot2
end

function slot0.SelectTag(slot0, slot1, slot2)
	slot5 = slot0:GetFilterData(slot1) or 0
	slot6 = uv0.lshift(1, CommonFilterConst.GetTagIndexAtGroup(slot1, slot2))
	slot7 = slot5
	slot7 = CommonFilterConst.GetGroupCfg(slot1).mode == Filter_Group_Mode.SingleMode and slot6 or uv0.bor(slot5, slot6)

	slot0:SetFilterGroupMask(slot1, slot7)

	return slot7
end

function slot0.DeSelectTag(slot0, slot1, slot2)
	slot5 = slot0:GetFilterData(slot1) or 0
	slot7 = slot5
	slot7 = CommonFilterConst.GetGroupCfg(slot1).mode == Filter_Group_Mode.SingleMode and 0 or uv0.bxor(slot5, uv0.lshift(1, CommonFilterConst.GetTagIndexAtGroup(slot1, slot2)))

	slot0:SetFilterGroupMask(slot1, slot7)

	return slot7
end

function slot0.HasIndexFlag(slot0, slot1, slot2)
	return slot0:HasFlag(slot1, uv0.lshift(1, CommonFilterConst.GetTagIndexAtGroup(slot1, slot2)))
end

function slot0.HasIndexFlagList(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot2 or {}) do
		slot3 = uv0.bor(0, uv0.lshift(1, CommonFilterConst.GetTagIndexAtGroup(slot1, slot8)))
	end

	return slot0:HasFlag(slot1, slot3)
end

function slot0.AllIndexFlagPast(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot2 or {}) do
		slot3 = uv0.bor(0, uv0.lshift(1, CommonFilterConst.GetTagIndexAtGroup(slot1, slot8)))
	end

	return slot0:LessEqualFlag(slot1, slot3)
end

function slot0.SpecificHasFlag(slot0, slot1, slot2)
	if (slot0:GetFilterData(slot1) or 0) == 0 then
		return true
	end

	for slot8, slot9 in ipairs(slot2 or {}) do
		slot4 = uv0.bor(0, uv0.lshift(1, CommonFilterConst.GetTagIndexAtGroup(slot1, slot9)))
	end

	return slot0:HasFlag(slot1, slot4)
end

function slot0.GetGroupSelectedTags(slot0, slot1)
	slot2 = {}

	if CommonFilterConst.GetGroupCfg(slot1) then
		for slot8, slot9 in ipairs(slot3.tags) do
			if slot0:HasIndexFlag(slot1, slot9) then
				table.insert(slot2, slot9)
			end
		end
	end

	return slot2
end

function slot0.AtLeastOneChoose(slot0)
	for slot5, slot6 in ipairs(CommonFilterConst.GetFilterGroups(slot0.filterId)) do
		if slot0:GetFilterData(slot6) and slot7 > 0 then
			return true
		end
	end

	return false
end

function slot0.AtLeastOneChooseGroup(slot0, slot1)
	if slot0:GetFilterData(slot1) and slot2 > 0 then
		return true
	end

	return false
end

function slot0.GetFilterData(slot0, slot1)
	return slot0.data[slot1]
end

function slot0.SetFilterGroupMask(slot0, slot1, slot2)
	slot0.data[slot1] = slot2
end

function slot0.CheckIsSame(slot0, slot1)
	slot2 = true
	slot4 = 0

	for slot8, slot9 in pairs(slot0.data) do
		slot3 = 0 + 1

		if not slot1:GetFilterData(slot8) or slot9 ~= slot1:GetFilterData(slot8) then
			slot2 = false
		end
	end

	for slot8, slot9 in pairs(slot1.data) do
		if slot9 > 0 then
			slot4 = slot4 + 1
		end
	end

	if slot3 == 0 and slot4 ~= 0 then
		slot2 = false
	end

	return slot2
end

return slot0
