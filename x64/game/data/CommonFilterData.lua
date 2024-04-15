slot0 = import("game.data.Filter.FilterTemplate")
slot1 = singletonClass("CommonFilterData")

function slot1.Init(slot0)
	slot0.data = {}
end

function slot1.Clear(slot0)
	slot0.data = {}
end

function slot1.GetFilter(slot0, slot1)
	if not slot0.data[slot1] then
		slot0.data[slot1] = uv0.New(slot1)
	end

	return slot0.data[slot1]
end

function slot1.ClearGroup(slot0, slot1, slot2)
	slot0:GetFilter(slot1):ClearGroup(slot2)
end

function slot1.ClearFilter(slot0, slot1)
	slot0:GetFilter(slot1):Clear()
end

function slot1.IsAll(slot0, slot1)
	if slot0.data[slot1] then
		return slot0:GetFilter(slot1):IsAll()
	else
		return true
	end
end

function slot1.HasFlag(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):HasFlag(slot2, slot3)
end

function slot1.LessEqualFlag(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):LessEqualFlag(slot2, slot3)
end

function slot1.SelectTag(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):SelectTag(slot2, slot3)
end

function slot1.DeSelectTag(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):DeSelectTag(slot2, slot3)
end

function slot1.HasIndexFlag(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):HasIndexFlag(slot2, slot3)
end

function slot1.HasIndexFlagList(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):HasIndexFlagList(slot2, slot3)
end

function slot1.AllIndexFlagPast(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):AllIndexFlagPast(slot2, slot3)
end

function slot1.SpecificHasFlag(slot0, slot1, slot2, slot3)
	return slot0:GetFilter(slot1):SpecificHasFlag(slot2, slot3)
end

function slot1.GetGroupSelectedTags(slot0, slot1, slot2)
	return slot0:GetFilter(slot1):GetGroupSelectedTags(slot2)
end

function slot1.AtLeastOneChoose(slot0, slot1)
	return slot0:GetFilter(slot1):AtLeastOneChoose()
end

function slot1.AtLeastOneChooseGroup(slot0, slot1, slot2)
	return slot0:GetFilter(slot1):AtLeastOneChooseGroup(slot2)
end

function slot1.GetFilterDataCopy(slot0, slot1)
	return deepClone(slot0:GetFilter(slot1))
end

function slot1.ApplyFilterCopy(slot0, slot1)
	if slot1 then
		slot0.data[slot1.filterId] = slot1
	end
end

return slot1
