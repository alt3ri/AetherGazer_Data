slot0 = class("Guide_8", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 801)
	table.insert(slot1, 802)
	table.insert(slot1, 804)

	if HeroData:GetHeroData(1084).weapon_info and slot2.weapon_info.level == 1 and slot0:HaveAddWeaponExpMaterial() then
		table.insert(slot1, 805)
		table.insert(slot1, 806)
		table.insert(slot1, 807)
		table.insert(slot1, 808)
		table.insert(slot1, 809)
	end

	if (not HeroTools.GetHeroServantInfo(1084) or slot4 == 0) and #WeaponServantData:GetWeaponServantList() ~= 0 then
		table.insert(slot1, 810)
		table.insert(slot1, 811)
		table.insert(slot1, 812)
		table.insert(slot1, 813)
		table.insert(slot1, 814)
		table.insert(slot1, 815)
	end

	table.insert(slot1, 816)
	table.insert(slot1, 817)
	table.insert(slot1, 818)

	slot0._steps = {}

	for slot9 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot9]) then
			table.insert(slot0._steps, slot11)
		end
	end
end

function slot0.HaveAddWeaponExpMaterial(slot0)
	slot4 = ItemConst.ITEM_TYPE.MATERIAL

	for slot4, slot5 in ipairs(ItemCfg.get_id_list_by_type[slot4]) do
		if ItemCfg[slot5].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and ItemTools.getItemNum(slot5) > 0 then
			return true
		end
	end

	return false
end

return slot0
