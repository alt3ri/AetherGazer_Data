slot0 = singletonClass("MaterialData")

function slot0.Init(slot0)
	slot0.materialList_ = {}
	slot0.expiredMaterialList_ = {}
end

function slot0.InitExpiredMaterialList(slot0, slot1)
	slot0.expiredMaterialList_ = {}

	for slot5, slot6 in ipairs(slot1) do
		if slot6.num > 0 then
			table.insert(slot0.expiredMaterialList_, {
				id = slot6.id,
				num = slot6.num,
				timeValid = slot6.time_valid
			})
		end
	end

	manager.notify:Invoke(MATERIAL_EXPIRED)
end

function slot0.InitMaterialList(slot0, slot1)
	slot0.materialList_ = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.id
		slot0.materialList_[slot7] = slot0.materialList_[slot7] or {}
		slot0.materialList_[slot7][slot6.time_valid or 0] = slot6.num
	end

	manager.notify:Invoke(MATERIAL_INIT)
end

function slot0.SetMaterialValue(slot0, slot1, slot2, slot3)
	slot0.materialList_[slot1] = slot0.materialList_[slot1] or {}
	slot4 = false

	if slot0.materialList_[slot1][slot3 or 0] == nil or slot2 == 0 then
		slot4 = true
	end

	if slot2 == 0 then
		slot0.materialList_[slot1][slot3] = nil
	else
		slot0.materialList_[slot1][slot3] = slot2
	end

	manager.notify:Invoke(MATERIAL_MODIFY, slot1, slot3, slot2)

	if slot4 then
		manager.notify:Invoke(MATERIAL_LIST_UPDATE, slot1)
	end
end

function slot0.GetMaterialNum(slot0, slot1, slot2)
	slot2 = slot2 or 0

	if slot0.materialList_[slot1] == nil then
		return 0
	else
		return slot0.materialList_[slot1][slot2] or 0
	end
end

function slot0.MaterialList(slot0)
	return slot0.materialList_
end

function slot0.GetMaterialListById(slot0, slot1)
	return slot0.materialList_[slot1] or {}
end

function slot0.CheckExpiredMaterialList(slot0)
	return slot0.expiredMaterialList_
end

function slot0.ClearExpiredMaterialList(slot0)
	slot0.expiredMaterialList_ = {}
end

function slot0.IsItemInExpiredMaterialList(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.expiredMaterialList_) do
		if slot6.id == slot1.id then
			return true
		end
	end

	return false
end

function slot0.IsItemHaveServeTick(slot0, slot1)
	for slot5, slot6 in pairs(slot0.materialList_[slot1] or {}) do
		if slot5 > 0 then
			return true
		end
	end

	return false
end

return slot0
