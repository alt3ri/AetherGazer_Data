slot0 = singletonClass("HeroData", BaseHeroViewData)
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = false
slot5 = true
slot6 = 0
slot7 = {}
slot8 = {}
slot9 = {}
slot10 = {}
slot11 = {}

function slot0.InitHero(slot0, slot1, slot2)
	uv0 = {}
	uv1 = {}
	uv2 = {}

	slot0:ResetSortValue()

	uv3 = {}
	uv4 = {}

	for slot6, slot7 in ipairs(slot2) do
		uv4[slot7.id] = slot7.num
	end

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot7.hero_base_info

		DefalutHeroDataTemplate.New(slot8.id):Init(slot7)

		slot9.piece = uv4[slot8.id or 0]
		uv3[slot8.id] = slot9
	end

	for slot6, slot7 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if uv3[slot7] then
			uv0[slot7] = uv3[slot7]
		else
			uv0[slot7] = DefalutHeroDataTemplate.New(slot7)
		end

		uv0[slot7].piece = uv4[slot7] or 0
		slot12 = uv0[slot7]

		for slot11, slot12 in ipairs(slot10.GetEquipInfoList(slot12)) do
			if slot12.equip_id ~= 0 then
				uv1[slot12.equip_id] = slot7
			end
		end
	end

	manager.notify:Invoke(HERO_DATA_INIT)
	HeroTools.DispatchAllHeroNewRed("unlockHero", RedPointConst.HERO_ID)
	HeroTools.DispatchAllHeroNewRed("unlockRelation", RedPointConst.HERO_REALTION .. "_")
	HeroTools.DispatchAllHeroNewRed("unlockSkin", RedPointConst.HERO_SKIN_ID)
end

function slot0.ModifyHero(slot0, slot1)
	uv0[slot1.hero_base_info.id]:ModifyHero(slot1)

	uv0[slot1.hero_base_info.id].piece = uv1[slot1.hero_base_info.id] or 0

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1.hero_base_info.id)
end

function slot0.ModifyHeroPieceByList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id].piece = slot6.num
		uv1[slot6.id] = slot6.num
	end

	manager.notify:Invoke(HERO_DATA_INIT)
end

function slot0.HeroPieceModify(slot0, slot1, slot2)
	uv0[slot1].piece = slot2

	manager.notify:Invoke(HERO_PIECE_MODIFY, slot1)
end

function slot0.AddHeroExpSuccess(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetHeroData(slot1)
	slot4.level = slot2
	slot4.exp = slot3

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.BreakSuccess(slot0, slot1, slot2)
	slot0:GetHeroData(slot1).break_level = slot2

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.UnlockHeroSuccess(slot0, slot1)
	slot0:GetHeroData(slot1).unlock = 1

	HeroTools.SetHeroNewTagRed(slot1, "unlockHero", RedPointConst.HERO_ID .. slot1, true)
	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
	manager.notify:Invoke(HERO_UNLOCK_SUCCESS, slot1)
end

function slot0.HeroClearTimesModify(slot0, slot1, slot2)
	if slot0:GetHeroData(slot1) == nil then
		return
	end

	slot3.clear_times = (slot3.clear_times or 0) + slot2
end

function slot0.EquipSwap(slot0, slot1, slot2, slot3)
	if slot1 ~= 0 then
		slot5 = uv1[slot1]:GetEquipInfoList()[slot3].equip_id

		if uv0[slot2] and slot4 ~= 0 then
			uv1[slot4]:GetEquipInfoList()[slot3].equip_id = slot5

			if slot5 and slot5 ~= 0 then
				uv0[slot5] = slot4
			end
		else
			uv0[slot5] = nil
		end

		uv1[slot1]:GetEquipInfoList()[slot3].equip_id = slot2

		if slot2 ~= 0 then
			uv0[slot2] = slot1
		end

		manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
	end
end

function slot0.EquipUnloadAll(slot0, slot1)
	slot2 = uv0[slot1]
	slot7 = slot2

	for slot6, slot7 in ipairs(slot2.GetEquipInfoList(slot7)) do
		if slot7.equip_id ~= 0 then
			uv1[slot7.equip_id] = nil
			slot7.equip_id = 0
		end
	end

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.AstrolabeUnlock(slot0, slot1, slot2)
	if not table.keyof(uv0[slot1].unlocked_astrolabe, slot2) then
		table.insert(slot3, slot2)
	end
end

function slot0.AstrolabeEquip(slot0, slot1, slot2)
	if not table.keyof(uv0[slot1].using_astrolabe, slot2) then
		table.insert(slot3, slot2)
	end

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.AstrolabeEquipAll(slot0, slot1, slot2)
	uv0[slot1].using_astrolabe = deepClone(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot2])

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.AstrolabeEquipByList(slot0, slot1, slot2)
	uv0[slot1].using_astrolabe = slot2

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.AstrolabeUnload(slot0, slot1, slot2)
	if table.keyof(uv0[slot1].using_astrolabe, slot2) then
		table.remove(slot3, slot4)
		uv1:AstrolabeUnload(slot1, slot2 + 1)
		manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
	end
end

function slot0.AstrolabeUnloadAll(slot0, slot1)
	uv0[slot1].using_astrolabe = {}

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.WeaponStr(slot0, slot1, slot2, slot3)
	uv0[slot1]:GetWeaponInfo().level = slot2
	uv0[slot1]:GetWeaponInfo().exp = slot3

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.WeaponBreak(slot0, slot1, slot2)
	uv0[slot1]:GetWeaponInfo().breakthrough = slot2

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.ServantReplace(slot0, slot1, slot2)
	uv0[slot1].servant_uid = slot2

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.HeroSkillUpgrade(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetHeroData(slot1)
	slot9 = slot4

	for slot8, slot9 in ipairs(slot4.GetSkillInfoList(slot9)) do
		if slot9.skill_id == slot2 then
			slot9.skill_level = slot9.skill_level + (slot3 or 1)

			break
		end
	end
end

function slot0.HeroSkillAttrUpgrade(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetHeroData(slot1)
	slot9 = slot4

	for slot8, slot9 in ipairs(slot4.GetSkillAttrList(slot9)) do
		if slot9.index == slot2 then
			slot9.level = slot9.level + (slot3 or 1)

			manager.notify:Invoke(HERO_DATA_MODIFY, slot1)

			return
		end
	end

	table.insert(slot4:GetSkillAttrList(), {
		index = slot2,
		level = slot3
	})
	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.HeroStarUp(slot0, slot1)
	slot2 = slot0:GetHeroData(slot1)
	slot3 = HeroStarCfg[slot2.star]
	slot6, slot7 = HeroTools.GetNextStarAndPhase(slot3.star, slot3.phase)
	slot2.star = HeroTools.GetStarCfgId(slot6, slot7)

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.SelectSkin(slot0, slot1, slot2)
	slot0:GetHeroData(slot1).using_skin = slot2
end

function slot0.GetHeroListExcept(slot0, slot1)
	for slot6, slot7 in pairs(uv0) do
		if not table.indexof(slot1, slot6) then
			-- Nothing
		end
	end

	return {
		[slot6] = slot7
	}
end

function slot0.GetHeroList(slot0)
	return uv0
end

function slot0.GetEquipMap(slot0)
	return uv0
end

function slot0.GetHeroOmegaNeedPiece(slot0, slot1)
	slot3 = HeroCfg[slot1]
	slot4 = 0

	if HeroData:GetHeroData(slot1).unlock == 1 then
		for slot12 = table.keyof(HeroStarCfg.all, HeroTools.GetStarCfgId(HeroStarCfg[slot2.star].star, HeroStarCfg[slot2.star].phase)), #HeroStarCfg.all do
			slot4 = slot4 + HeroStarCfg[HeroStarCfg.all[slot12]].star_up
		end

		return math.max(0, slot4 - slot2.piece)
	else
		slot6 = GameSetting.unlock_hero_need.value[slot3.rare]

		for slot10 = 1, #HeroStarCfg.all do
			slot4 = slot4 + HeroStarCfg[HeroStarCfg.all[slot10]].star_up
		end

		return slot6 + slot4
	end
end

function slot0.GetHeroNum(slot0)
	for slot5, slot6 in pairs(uv0) do
		if slot6.unlock == 1 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.GetUnlockHeros(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6.unlock == 1 then
			table.insert(slot1, slot6.id)
		end
	end

	return slot1
end

function slot0.InitFavorite(slot0, slot1)
	uv0 = slot1 or {}
end

function slot0.IsFavorite(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.SetFavoriteHeroOn(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.SetFavoriteHeroOff(slot0, slot1)
	if table.indexof(uv0, slot1) then
		table.remove(uv0, slot2)
	end
end

function slot0.SaveSortValue(slot0, slot1, slot2, slot3, slot4, slot5)
	uv0 = slot1 == nil and true or slot1
	uv1 = slot2 or 0
	uv2 = slot3 or {}
	uv3 = slot4 or {}
	uv4 = slot5 or {}
end

function slot0.SaveSortType(slot0, slot1)
	uv0 = slot1 or 0
end

function slot0.GetSortValue(slot0)
	return uv0, uv1, uv2, uv3, uv4
end

function slot0.ResetSortValue(slot0)
	uv0 = true
	uv1 = 0
	uv2 = {}
	uv3 = {}
	uv4 = {}
end

function slot0.ImproveTransitionGiftPt(slot0, slot1)
	if slot0:GetHeroTransitionSkillBySlotID(slot1.hero_id, slot1.slot_id) then
		slot2.talent_points = slot2.talent_points + slot1.lv_up_num
	else
		table.insert(uv0[slot1.hero_id]:GetTransitionInfoList(), {
			slot_id = slot1.slot_id,
			skill_list = {},
			talent_points = slot1.lv_up_num
		})
	end
end

function slot0.ModifyTransitionSkill(slot0, slot1)
	if slot0:GetHeroTransitionSkillBySlotID(slot1.hero_id, slot1.slot_id) then
		slot2.skill_list = cleanProtoTable(slot1.skill_list)

		manager.notify:Invoke(HERO_TRANSITION_CHANGE, {
			heroId = slot1.hero_id
		})
	end
end

function slot0.GetHeroTransitionSkillBySlotID(slot0, slot1, slot2)
	slot3 = uv0[slot1]
	slot8 = slot3

	for slot7, slot8 in ipairs(slot3.GetTransitionInfoList(slot8)) do
		if slot8.slot_id == slot2 then
			return slot8
		end
	end

	return false
end

function slot0.GetCurModuleLevel(slot0, slot1)
	return uv0[slot1] and uv0[slot1].moduleLevel or 0
end

function slot0.GetModuleMaxLevel(slot0, slot1)
	return #WeaponModuleCfg[slot1].cost
end

function slot0.ModuleLevelUp(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].moduleLevel = uv0[slot1].moduleLevel + 1
	end
end

function slot0.GetModuleAssignmentIsFinish(slot0, slot1)
	if uv0[slot1] then
		if uv0[slot1].moduleAssignment > 0 then
			return true
		else
			return false
		end
	end

	return false
end

function slot0.GetModulePowersByHeroID(slot0, slot1)
	slot2 = {}
	slot3 = slot0:GetCurModuleLevel(slot1)

	if WeaponModuleCfg[slot1] then
		for slot8 = 1, slot3 do
			for slot13, slot14 in pairs(slot4.skill[slot8]) do
				table.insert(slot2, slot14)
			end
		end
	end

	return slot2
end

function slot0.GetAllModulePowersByHeroID(slot0, slot1)
	slot2 = {}
	slot3 = slot0:GetModuleMaxLevel(slot1)

	if WeaponModuleCfg[slot1] then
		for slot8 = 1, slot3 do
			for slot13, slot14 in pairs(slot4.skill[slot8]) do
				table.insert(slot2, slot14)
			end
		end
	end

	return slot2
end

function slot0.GetCurModuleEffectListByType(slot0, slot1, slot2, slot3)
	slot5 = {}

	for slot9, slot10 in pairs(HeroTools:GetModulePowersByHeroIDAndLevel(slot1, slot3)) do
		if WeaponModuleEffectCfg[slot10].type == slot2 then
			table.insert(slot5, slot10)
		end
	end

	if slot5[1] then
		return slot5
	else
		return nil
	end
end

function slot0.GetLockModuleEffectListByType(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in pairs(WeaponModuleCfg[slot1].skill[1]) do
		if WeaponModuleEffectCfg[slot9].type == slot2 then
			table.insert(slot4, slot9)
		end
	end

	if slot4[1] then
		return slot4
	else
		return nil
	end
end

function slot0.UnlockTrust(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].trust.level = 1
		uv0[slot1].trust.exp = 0
		uv0[slot1].trust.mood = slot2
	end

	HeroAction.UpdateSuperStoryRedPoint()
	HeroTools.SetHeroNewTagRed(slot1, "unlockRelation", table.concat({
		RedPointConst.HERO_REALTION,
		"_",
		slot1
	}), true)
end

function slot0.UpgradeTrustLevel(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].trust.level = uv0[slot1].trust.level + 1
		uv0[slot1].trust.exp = 0
	end

	HeroAction.UpdateSuperStoryRedPoint()
end

function slot0.UnlockRelationNet(slot0, slot1, slot2, slot3)
	if uv0[slot1] then
		uv0[slot1].relation:UnlockRelationNet(slot2, slot3)
	end
end

function slot0.SetupHeroMainOpenStatus(slot0, slot1)
	uv0 = slot1
end

function slot0.GetHeroMainOpenStatus(slot0)
	return uv0
end

function slot0.SetHeroStrategyRedPoint(slot0, slot1)
	saveData("strategy", "strategy_" .. slot1, "1")
end

function slot0.GetHeroStrategyRedPoint(slot0, slot1)
	return getData("strategy", "strategy_" .. slot1) ~= "1" and not (BattleTeachData:GetHeroTeachInfo(slot1, HeroCfg[slot1].study_stage[1]) > 0)
end

function slot0.Init(slot0)
	_G.heroViewPageIndex_ = 1
end

return slot0
