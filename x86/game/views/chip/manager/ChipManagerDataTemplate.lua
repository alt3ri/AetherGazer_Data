slot0 = class("ChipManagerDataTemplate")

function slot0.Ctor(slot0, slot1)
	slot0.enabledChipManagerID_ = 0
	slot0.unlockChipManagerIDList_ = {}
	slot0.unlockChipIDList_ = {}
	slot0.isNoRed = false

	slot0:InitData(slot1)

	slot0.useChipmanagerId = 0
	slot0.useChipIdList = {}
end

function slot0.InitData(slot0, slot1)
	slot0.enabledChipManagerID_ = slot1.id or 0
	slot0.unlockChipManagerIDList_ = slot1.unlockChipManagerIDList_ or {}
	slot0.unlockChipIDList_ = slot1.unlockChipIDList_ or {}
	slot0.isNoRed = slot1.isNoRed
end

function slot0.GetChipManagerIsUnLock(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.unlockChipManagerIDList_) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.GetIsUnlockChip(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.unlockChipIDList_) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.SetUseChipmanagerId(slot0, slot1)
	slot0.useChipmanagerId = slot1
end

function slot0.SetUseChipId(slot0, slot1)
	if #slot0.useChipIdList < GameSetting.ai_secondary_chip_equip_num.value[1] and not slot0:GetIsUesChipID(slot1) then
		if not slot0.useChipIdList then
			slot0.useChipIdList = {}
		end

		table.insert(slot0.useChipIdList, slot1)
	end
end

function slot0.SetNoUseChipId(slot0, slot1)
	if slot0.useChipIdList[table.indexof(slot0.useChipIdList, slot1)] then
		table.remove(slot0.useChipIdList, slot2)
	end
end

function slot0.GetIsUesChipID(slot0, slot1)
	return table.indexof(slot0.useChipIdList, slot1)
end

function slot0.GetISUseChipmanager(slot0, slot1)
	return slot0.useChipmanagerId == slot1
end

function slot0.SetTeamInfo(slot0, slot1, slot2, slot3)
	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.sectionProxy_ = slot3
	slot0.useChipmanagerId = slot3:GetMimirID()
	slot0.useChipIdList = slot3:GetMimirChipList()
end

function slot0.SetReservesIndex(slot0, slot1)
	slot0.reservesIndex_ = slot1
end

function slot0.SetChipInfoViewPath(slot0, slot1)
	slot0.chipInfoPath = slot1
end

function slot0.GetChipInfoViewPath(slot0)
	return slot0.chipInfoPath or "/chipInfo"
end

function slot0.SetChipSchemeViewPath(slot0, slot1)
	slot0.chipSchemePath = slot1
end

function slot0.GetChipSchemeViewPath(slot0)
	return slot0.chipSchemePath or "/chipScheme"
end

function slot0.GetEquipChipList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.useChipIdList or {}) do
		table.insert(slot1, slot6)
	end

	return slot1
end

return slot0
