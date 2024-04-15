slot0 = class("Guide_60", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()

	slot0.nowEquipData_ = slot0:CheckNowHeroData()

	table.insert(slot1, 6001)
	table.insert(slot1, 6002)
	table.insert(slot1, 6003)
	table.insert(slot1, 6004)

	if slot0.nowEquipData_ then
		table.insert(slot1, 6005)
	end

	slot2 = not slot0.nowEquipData_

	if slot0.nowEquipData_ and slot0.nowEquipData_.star == 2 and slot0.nowEquipData_.equipConfig.suit == 29 and slot0.nowEquipData_.equip_id ~= slot0.targetEquip_.equip_id then
		slot2 = true
	end

	if slot2 then
		table.insert(slot1, 6006)
		table.insert(slot1, 6007)

		if slot0.targetEquip_:GetEquipHero() then
			print("HERO")
			table.insert(slot1, 6008)
		end

		slot0.nowEquipData_ = slot0.targetEquip_
	end

	table.insert(slot1, 6009)
	table.insert(slot1, 6010)

	if slot0.nowEquipData_ and slot0.nowEquipData_:GetLevel() <= 1 and slot0:HaveAddEquipExpMaterial() then
		table.insert(slot1, 6011)
		table.insert(slot1, 6012)
	end

	slot0._steps = {}

	for slot7 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot7]) then
			table.insert(slot0._steps, slot9)
		end
	end
end

function slot0.CheckNowHeroData(slot0)
	if HeroData:GetHeroList()[1084] and slot1[1084].equip and slot1[1084].equip[1].equip_id and slot2.equip_id ~= 0 then
		return EquipData:GetEquipData(slot2.equip_id)
	end

	return nil
end

function slot0.HaveAddEquipExpMaterial(slot0)
	for slot4, slot5 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		if ItemCfg[slot5].sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and ItemTools.getItemNum(slot5) > 0 then
			return true
		end
	end

	return false
end

function slot0.CheckGuide(slot0)
	slot0.targetEquip_ = EquipData:GetEquipListComplex(ItemConst.SORT_TYPE.DOWN, EquipConst.EQUIP_SORT.LEVEL, 1)[1]

	return slot0.targetEquip_ ~= nil and GuideTool.SatisfyCondition(slot0.open_condition)
end

return slot0
