function getHeroPower(slot0, slot1)
	if slot1 then
		return TempHeroData:GetBattlePower(slot0)
	end

	return getBattlePower(HeroData:GetHeroData(slot0))
end

function getBattlePower(slot0)
	for slot5, slot6 in pairs(slot0.equip) do
		if slot6.equip_id ~= 0 then
			table.insert({}, EquipData:GetEquipList()[slot6.equip_id])
		end
	end

	slot2 = nil

	if slot0.servant_uid ~= nil and slot0.servant_uid ~= 0 then
		slot3 = WeaponServantData.GetWeaponServantList()[slot0.servant_uid]
		slot2 = {
			id = slot3.id,
			stage = slot3.stage
		}
	end

	return calcBattlePower(slot0, slot2, slot1)
end

function GetPracticalData(slot0)
	return HeroTools.GetConstructHero(slot0), slot0.equip_list
end

function GetVirtualData(slot0)
	for slot5, slot6 in ipairs(deepClone(TempHeroData:GetTempHeroDataByTempID(slot0)).skill) do
		slot6.skill_level = slot6.skill_level + HeroTools.GetHeroSkillAddLevel(slot1, slot6.skill_id)
	end

	return slot1, slot1.equip_list
end

function GetHeroPracticalAttr(slot0, slot1, slot2, slot3, slot4)
	slot5 = HeroTools.GetHeroAttribute(slot0)
	slot10 = slot4

	for slot10, slot11 in pairs(DormTools:GetDormAdditionByHeroID(slot0.id, slot0.dormLevel, slot10).attribute) do
		if slot5[slot10] == nil then
			slot5[slot10] = 0
		end

		slot5[slot10] = slot5[slot10] + slot11
	end

	slot7 = EquipTools.CalHeroVirtualEquipAttribute(slot2, slot0, slot3)
	slot8 = HeroTools.CalTransitionSkillAttribute(slot0, slot2)
	slot9 = WeaponTools.CalWeaponAttribute(slot0.id, slot0.weapon_info, slot1)
	slot10 = HeroTools.GetModuleAttribute(slot0)
	slot11 = HeroTools.GetSkillAttribute(slot0)
	slot12 = {}

	if slot0.relation then
		slot12 = slot0.relation:GetRelationNetAttr()
	end

	for slot16, slot17 in pairs(slot7) do
		slot5[slot16] = HeroTools.AttributeAdd(slot16, slot5[slot16], slot17)
	end

	for slot16, slot17 in pairs(slot8) do
		slot5[slot16] = HeroTools.AttributeAdd(slot16, slot5[slot16], slot17)
	end

	for slot16, slot17 in pairs(slot9) do
		slot5[slot16] = HeroTools.AttributeAdd(slot16, slot5[slot16], slot17)
	end

	for slot16, slot17 in pairs(slot10) do
		slot5[slot16] = HeroTools.AttributeAdd(slot16, slot5[slot16], slot17)
	end

	for slot16, slot17 in pairs(slot11) do
		slot5[slot16] = HeroTools.AttributeAdd(slot16, slot5[slot16], slot17)
	end

	for slot16, slot17 in pairs(slot12) do
		slot5[slot16] = HeroTools.AttributeAdd(slot16, slot5[slot16], slot17)
	end

	HeroTools.CalFinalAttribute(slot5)

	return slot5
end

function GetMatrixtHeroPracticalAttr(slot0, slot1, slot2, slot3, slot4)
	slot5 = HeroTools.GetHeroAttribute(slot0)

	if not slot4:GetIsOwnerHero() then
		if type(HeroStandardSystemCfg[slot2].hero_attrib) == "table" then
			for slot10, slot11 in pairs(slot6) do
				slot5[slot11[1]] = slot11[2]
			end
		end
	else
		slot7 = WeaponTools.CalWeaponAttribute(slot0.id, slot0.weapon_info, slot0.servantInfo)
		slot8 = HeroTools.CalTransitionSkillAttribute(slot0, slot1)

		for slot12, slot13 in pairs(EquipTools.CalHeroVirtualEquipAttribute(slot1, slot0)) do
			slot5[slot12] = HeroTools.AttributeAdd(slot12, slot5[slot12], slot13)
		end

		for slot12, slot13 in pairs(slot8) do
			slot5[slot12] = HeroTools.AttributeAdd(slot12, slot5[slot12], slot13)
		end

		for slot12, slot13 in pairs(slot7) do
			slot5[slot12] = HeroTools.AttributeAdd(slot12, slot5[slot12], slot13)
		end
	end

	slot6 = {}

	if slot3 then
		if ActivityTools.GetActivityType(slot3) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
			slot6 = ActivityMatrixData:CalMatrixAttribute(slot3)
		elseif slot7 == ActivityTemplateConst.STRATEGY_MATRIX then
			slot6 = StrategyMatrixData:CalMatrixAttribute(slot3)
		else
			error("GetMatrixtHeroPracticalAttr can not find current matrixAttr")
		end
	else
		slot6 = MatrixData:CalMatrixAttribute()
	end

	for slot10, slot11 in pairs(slot6) do
		slot5[slot10] = HeroTools.AttributeAdd(slot10, slot5[slot10], slot11)
	end

	HeroTools.CalFinalAttribute(slot5)

	return slot5
end

function GetPolyhedronHeroPracticalAttr(slot0, slot1, slot2, slot3)
	slot4 = HeroTools.GetHeroAttribute(slot1)
	slot6 = HeroTools.CalTransitionSkillAttribute(slot1, slot2)
	slot7 = clone(slot1.weapon_info)
	slot7.exp = 0
	slot8 = WeaponTools.CalWeaponAttribute(slot1.id, slot7, slot1.servantInfo)

	for slot12, slot13 in pairs(EquipTools.CalHeroVirtualEquipAttribute(slot2, slot1)) do
		slot4[slot12] = HeroTools.AttributeAdd(slot12, slot4[slot12], slot13)
	end

	for slot12, slot13 in pairs(slot6) do
		slot4[slot12] = HeroTools.AttributeAdd(slot12, slot4[slot12], slot13)
	end

	for slot12, slot13 in pairs(slot8) do
		slot4[slot12] = HeroTools.AttributeAdd(slot12, slot4[slot12], slot13)
	end

	for slot13, slot14 in pairs(slot0:CalPolyhedronAttribute(slot1.id)) do
		slot4[slot13] = HeroTools.AttributeAdd(slot13, slot4[slot13], slot14)
	end

	if type(HeroStandardSystemCfg[slot3].hero_attrib) == "table" then
		for slot14, slot15 in pairs(slot10) do
			slot4[slot15[1]] = slot15[2]
		end
	end

	HeroTools.CalFinalAttribute(slot4)

	return slot4
end

function GetHeroFinalAttr(slot0, slot1, slot2, slot3, slot4)
	if slot3 and slot3 ~= 0 then
		if type(HeroStandardSystemCfg[slot3].hero_attrib) == "table" then
			for slot10, slot11 in pairs(slot5) do
				-- Nothing
			end

			return {
				[slot11[1]] = slot11[2]
			}
		else
			return GetHeroPracticalAttr(slot0, slot1, slot2, slot4, true)
		end
	end

	return GetHeroPracticalAttr(slot0, slot1, slot2, slot4, false)
end

function calcBattlePower(slot0, slot1, slot2, slot3, slot4)
	slot5 = 0
	slot6 = nil
	slot6 = slot4 and slot4 or GetHeroFinalAttr(slot0, slot1, slot2, slot3, true)
	slot7 = slot6[HeroConst.HERO_ATTRIBUTE.ATK] or 0
	slot8 = slot6[HeroConst.HERO_ATTRIBUTE.STA] or 0
	slot9 = slot6[HeroConst.HERO_ATTRIBUTE.ARM] or 0
	slot10 = (slot6[HeroConst.HERO_ATTRIBUTE.CRITICAL_RATE] or 5000) / 1000 or 0

	for slot15, slot16 in pairs(slot0.skill) do
		slot11 = 0 + slot16.skill_level + HeroTools.GetHeroSkillAddLevel(slot0, slot16.skill_id)
	end

	for slot15, slot16 in pairs(slot0.skillAttrList) do
		slot11 = slot11 + slot16.level
	end

	for slot17, slot18 in pairs(EquipTools.CountHeroTotalSkill(slot2, slot0)) do
		slot12 = 0 + slot18
	end

	slot14 = 0
	slot15 = {}

	for slot19, slot20 in pairs(slot2) do
		if slot20.prefab_id ~= 0 then
			slot15[slot22] = 1 + (slot15[EquipCfg[slot20.prefab_id].suit] or 0)
		end
	end

	slot16 = HeroTools.GetIsSuitNumCut(slot0)

	for slot20, slot21 in pairs(slot15) do
		for slot26, slot27 in ipairs(EquipSuitCfg.get_id_list_by_suit[slot20]) do
			if EquipTools.GetSuitNeedNum(slot27, slot16) <= slot21 then
				slot14 = slot14 + 1
			end
		end
	end

	for slot21, slot22 in pairs(slot0.using_astrolabe) do
		if slot22 ~= 0 then
			slot17 = 0 + 1
		end
	end

	slot18 = 0

	if slot1 ~= nil then
		slot19 = HeroTools.GetHeroWeaponAddLevel(slot0)

		if WeaponServantCfg[slot1.id] and slot20.type ~= 3 then
			slot21 = 0.3

			if slot20.starlevel == 3 then
				slot21 = 0.3
			elseif slot20.starlevel == 4 then
				slot21 = 0.6
			elseif slot20.starlevel == 5 then
				slot21 = 0.8
			end

			if slot20.type == 2 and math.floor(slot20.effect[1] / 100) == slot0.id then
				slot21 = 1
			end

			slot18 = slot21 * (214 * (slot1.stage + slot19) + 746)
		end
	end

	slot19 = HeroTools.CountTransitionTotalSkill(slot0, slot2)
	slot22 = 8

	if HeroCfg[slot0.id].unlock_star / 100 == 1 then
		slot22 = 8
	elseif slot21 == 2 then
		slot22 = 10
	elseif slot21 == 3 then
		slot22 = 16
	end

	slot23 = nil

	return math.floor(slot7 * 1 + slot8 * 0.15 + slot9 * 0.8 + slot10 * 2400 + slot11 * slot22 + slot17 * (HeroTools.IsSpHero(slot0.id) and 133 or 355) + slot12 * 128 + slot14 * 400 + slot18 + slot19 * 60)
end
