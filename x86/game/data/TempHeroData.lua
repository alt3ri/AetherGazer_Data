slot0 = singletonClass("TempHeroData", BaseHeroViewData)
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.GetHeroList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if not uv0[slot7] then
			slot0:GetTempHeroDataByTempID(slot7)
		end

		slot2[slot7] = uv0[slot7]
	end

	return slot2
end

function slot0.GetTempHeroDataByTempID(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	end

	slot2 = HeroStandardSystemCfg[slot1]
	uv0[slot1] = TemplateHeroDataTemplate.New(SkinCfg[slot2.skin_id].hero)

	uv0[slot1]:Init(slot2)

	return uv0[slot1]
end

function slot0.GetTempHeroList(slot0, slot1)
	slot2, slot3 = nil
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if HeroStandardSystemCfg[slot9] then
			table.insert(slot4, SkinCfg[slot2.hero_id].hero)
		end
	end

	return slot4
end

function slot0.GetHeroData(slot0, slot1, slot2)
	slot3 = nil

	for slot7, slot8 in ipairs(slot2) do
		if slot0:GetTempHeroDataByTempID(slot8).id == slot1 then
			return slot3
		end
	end

	return {}
end

function slot0.GetBattlePower(slot0, slot1)
	slot2 = slot0:GetTempHeroDataByTempID(slot1)

	return calcBattlePower(slot2, slot2.servantInfo, slot2.equip_list, slot1)
end

function slot0.GetEquipInfoList(slot0, slot1, slot2)
	return slot0:GetHeroData(slot1, slot2):GetEquipInfoList()
end

function slot0.GetEquipDataList(slot0, slot1, slot2)
	return slot0:GetHeroData(slot1, slot2).equip_list
end

function slot0.GetHeroWeaponInfo(slot0, slot1, slot2)
	return slot0:GetHeroData(slot1, slot2).weapon_info
end

function slot0.GetHeroUsingSkinInfo(slot0, slot1, slot2)
	if (slot0:GetHeroData(slot1, slot2) and slot3.using_skin or 0) == 0 then
		slot4 = slot1
	end

	return SkinCfg[slot4]
end

function slot0.GetHeroServantInfo(slot0, slot1, slot2)
	return slot0:GetHeroData(slot1, slot2):GetServantInfo()
end

function slot0.GetHeroSkillInfoList(slot0, slot1, slot2)
	return slot0:GetHeroData(slot1, slot2):GetSkillInfoList()
end

function slot0.GetHeroTransitionInfoList(slot0, slot1, slot2)
	return slot0:GetHeroData(slot1, slot2):GetTransitionInfoList()
end

return slot0
