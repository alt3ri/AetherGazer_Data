slot0 = class("BaseHeroViewData")

function slot0.GetHeroList(slot0)
	Debug.LogError("Need to override function GetHeroList()")

	return {}
end

function slot0.GetHeroIDList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot0:GetHeroList(slot1)) do
		table.insert(slot2, slot8.id)
	end

	return slot2
end

function slot0.GetHeroData(slot0, slot1)
	return slot0:GetHeroList()[slot1]
end

function slot0.GetEquipInfoList(slot0, slot1)
	return slot0:GetHeroData(slot1):GetEquipInfoList()
end

function slot0.GetEquipDataList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:GetEquipInfoList(slot1)) do
		if slot8.equip_id ~= 0 then
			table.insert(slot2, EquipData:GetEquipData(slot8.equip_id))
		else
			table.insert(slot2, EquipStruct.New(0, slot8.equip_id))
		end
	end

	return slot2
end

function slot0.GetHeroWeaponInfo(slot0, slot1)
	return slot0:GetHeroData(slot1):GetWeaponInfo()
end

function slot0.GetHeroServantInfo(slot0, slot1)
	return slot0:GetHeroData(slot1):GetServantInfo()
end

function slot0.GetHeroSkillInfoList(slot0, slot1)
	return slot0:GetHeroData(slot1):GetSkillInfoList()
end

function slot0.GetHeroTransitionInfoList(slot0, slot1)
	return slot0:GetHeroData(slot1):GetTransitionInfoList()
end

function slot0.GetHeroUsingSkinInfo(slot0, slot1)
	if (slot0:GetHeroData(slot1) and slot2.using_skin or 0) == 0 then
		slot3 = slot1
	end

	return SkinCfg[slot3]
end

function slot0.GetExFilterSorterFunc(slot0)
	return nil
end

return slot0
