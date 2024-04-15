slot0 = class("KagutsuchiMapGrid")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.x = slot1
	slot0.y = slot2
	slot0.index = slot3
	slot0.value = nil
end

function slot0.SetValue(slot0, slot1)
	slot0.value = slot1
end

slot1 = class("KagutsuchiMap")
slot2 = {
	null_grid = true
}

function slot1.Ctor(slot0, slot1, slot2)
	slot0.length = 0
	slot0.list = {}

	slot0:InitMap(slot1, slot2)
end

function slot1.Clear(slot0)
	slot0.length = 0
	slot0.list = {}
	slot0.grids = {}
end

function slot1.InitMap(slot0, slot1, slot2)
	slot0.width = slot1
	slot0.height = slot2
	slot0.grids = {}

	for slot6 = 1, slot1 do
		slot0.grids[slot6] = {}

		for slot10 = 1, slot2 do
			slot0.grids[slot6][slot10] = uv0
		end
	end
end

function slot1.GetGrid(slot0, slot1, slot2)
	if slot0:IsOverbound(slot1, slot2) then
		return uv0
	end

	if slot0.grids[slot1][slot2] == uv0 then
		return nil
	end

	return slot3.value
end

function slot1.GetGridByIndex(slot0, slot1)
	if slot0.list[slot1] == uv0 then
		return nil
	end

	return slot2.value
end

function slot1.GetGridXY(slot0, slot1)
	if slot0.list[slot1] == uv0 then
		return nil, 
	end

	return slot2.x, slot2.y
end

function slot1.GetGridIndex(slot0, slot1, slot2)
	if slot0:IsOverbound(slot1, slot2) then
		return nil
	end

	if slot0.grids[slot1][slot2] == uv0 then
		return nil
	end

	return slot3.index
end

function slot1.GetGridCount(slot0)
	return slot0.length
end

function slot1.PutGrid(slot0, slot1, slot2, slot3)
	if slot0:IsOverbound(slot1, slot2) then
		return nil
	end

	if slot0.grids[slot1][slot2] == uv0 then
		slot4 = uv1.New(slot1, slot2, slot0.length + 1)
		slot0.grids[slot1][slot2] = slot4
		slot0.list[slot4.index] = slot4
		slot0.length = slot0.length + 1
	end

	slot4:SetValue(slot3)

	return slot4.value
end

function slot1.HasGrid(slot0, slot1, slot2)
	return slot0:GetGrid(slot1, slot2) ~= uv0
end

function slot1.IsOverbound(slot0, slot1, slot2)
	return slot1 <= 0 or slot1 > slot0.width or slot2 <= 0 or slot2 > slot0.height
end

return slot1
