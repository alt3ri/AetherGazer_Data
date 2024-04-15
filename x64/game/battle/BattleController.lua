slot0 = singletonClass("BattleController")
slot1, slot2 = nil

function slot0.GetBattleStageData(slot0)
	return uv0
end

function slot0.GetRoomProxy(slot0)
	return uv0
end

function slot0.ClearRoomProxy(slot0)
	uv0 = nil
end

function slot0.SetBattleStageData(slot0, slot1)
	uv0 = slot1
end

function slot0.LaunchBattle(slot0, slot1, slot2, slot3)
	WaitStartBattle = nil
	slot4 = slot1:GetType()
	slot5 = slot1:GetDest()
	slot6 = slot1:GetMultiple()
	slot7 = slot1:GetType()
	slot8, slot9 = slot1:GetHeroTeam()
	slot10 = slot1:GetAssistHeroOwnerList()

	for slot16 = #clone(slot8), 1, -1 do
		if slot11[slot16] == 0 then
			table.remove(slot11, slot16)
			table.remove(clone(slot9), slot16)
		end
	end

	for slot16 = 1, 2 do
		for slot20 = slot16 + 1, 3 do
			if slot11[slot16] and slot11[slot20] and slot11[slot16] ~= 0 and slot11[slot16] == slot11[slot20] then
				ShowTips("TEAM_REPEAT_HERO")

				return
			end
		end
	end

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot7 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot7 then
		slot12 = slot1:GetSystemHeroTeam()
	end

	slot13 = slot1:GetComboSkillID() or 0
	slot14 = slot1:GetSystemHeroTeam()
	slot15 = {
		[slot19] = {}
	}

	for slot19, slot20 in ipairs(slot11) do
		if slot9[slot19] ~= 0 and slot9[slot19] ~= nil then
			slot15[slot19].hero_type = 2
			slot15[slot19].owner_id = BattleTeamData.NO_OWNER
			slot15[slot19].hero_id = slot9[slot19]
		elseif slot14[slot19] ~= 0 and slot14[slot19] ~= nil then
			slot15[slot19].hero_type = 2
			slot15[slot19].owner_id = BattleTeamData.NO_OWNER
			slot15[slot19].hero_id = slot14[slot19]
		else
			slot15[slot19].hero_id = slot11[slot19]
			slot15[slot19].owner_id = slot10[slot19] or BattleTeamData.NO_OWNER
			slot15[slot19].hero_type = not BattleTeamData.IsValidOwner(slot15[slot19].owner_id) and 1 or 3
		end
	end

	manager.net:SendWithLoadingNew(54030, {
		hero_list = slot15,
		dest = slot5,
		activity_id = slot1:GetActivityID() or 0,
		battle_times = slot6,
		type = slot7,
		index = slot1:GetServerExtant(),
		cooperate_unique_skill_id = slot13,
		battle_vs = LuaForUtil.GetBattleVersion(),
		mimir_info = {
			{
				mimir_id = slot1:GetChipManagerID(),
				chip_list = slot1:GetChipList()
			}
		}
	}, 54031, function (slot0)
		if uv0 then
			uv0(slot0)
		end

		if isSuccess(slot0.result) then
			uv1 = uv2
			uv3 = uv4

			manager.net:RegistPushWaiting(54007, function ()
			end)
		elseif slot0.result == 2109 and BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == uv5 then
			ShowTips(300114)
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.LaunchCooperationBattle(slot0)
	manager.net:SendWithLoadingNew(37014, {}, 37015, function (slot0)
		if isSuccess(slot0.result) then
			WaitStartBattle = nil
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.LaunchCooperationBattleWithoutRoom(slot0, slot1)
	slot2 = BattleStageFactory.Produce(slot1.battle_type, slot1.dest, {
		dest = slot1.dest,
		activityID = slot1.activity_id
	})

	BattleController.GetInstance():SetBattleStageData(slot2)
	slot2:UpdateRoleDatas()
	BattleFieldData:SetServerBattleParams(slot1.battle_id, slot1.server_ip, slot1.server_port)
	BattleController.GetInstance():StartBattle(true)
end

function slot0.LaunchStoryBattle(slot0, slot1, slot2, slot3)
	manager.story:CheckBattleStory(slot2, manager.story.BEFORE, function ()
		gameContext:Go("/blank")
		manager.net:SendWithLoadingNew(54034, {
			stage_id = uv0,
			activity_id = uv1
		}, 54035, function (slot0)
			if isSuccess(slot0.result) then
				uv3 = BattleStageFactory.Produce(uv0, uv1, uv2)

				uv3:SetIsStoryTag(true)

				slot3 = GetOldPlayerExp()

				manager.net:SendWithLoadingNew(54032, {
					battle_id = slot0.battle_id
				}, 54033, function (slot0, slot1)
					manager.story:RemovePlayer()
					BattleFieldData:FinishBattle(slot0)

					BattleCallLuaCallBackWait = false
					BattleCallLuaWaitLoading = false

					GotoTeam(uv0, slot0.battle_result, slot0.result, uv1)
				end)

				return
			end

			ShowTips(slot0.result)
			manager.story:RemovePlayer()
		end)
	end, false)
end

function slot0.UpdateHeroTeam(slot0, slot1)
	if not uv0 then
		error("Loss Current BattleStageData In UpdateHeroTeam")

		return
	end

	uv0:UpdateRoleDatas(slot1)
end

function slot0.StartBattle(slot0, slot1)
	if not uv0 then
		error("Loss Current BattleStageData In StartBattle")

		return
	end

	slot2 = uv0
	slot4, slot5 = BattleFieldData:GetBattleServerIPAndPort()
	slot6 = GetSceneDataForExcehange()
	slot6.leftTime = slot2:GetBattleTime() * 1000
	slot6.typeIDListAffix, slot6.levelList, slot6.enemyTypes = slot2:GetBattleStageAffix()
	slot6.mSceneID, slot11 = slot2:GetMap()

	LuaExchangeHelper.SetNewbie(slot11)

	slot6.needResurrect, slot13, slot6.coinNumber, slot6.coinConsume, slot16 = slot2:GetRevive()
	slot6.maxCoinNumber = slot16 or 0
	slot6.resurrectHP = slot2:GetResurrectHP()
	slot6.resurrectImmediately = slot2:GetResurrectImmediately()
	slot6.challengeFactor = slot2:GetMultiple()
	slot6.mMissionClearTimes = slot2:GetClearTime()
	slot6.difficulty = slot2:GetAILevel()
	slot6.adaptiveEnemyLevel = slot2:GetEnemyLevel()
	slot6.roleDataInLua = slot2:GetRoleDatas()
	slot17 = slot2:GetAttributeFactor()
	slot6.attributeFactor = Int3.New(slot17.x * 1000, slot17.y * 1000, slot17.z * 1000)
	slot6.cooperateUniqueSkillID = slot2:GetComboSkillID()
	slot6.cooperateUniqueSkillLevel = slot2:GetComboSkillLevel()
	slot6.maxRaceID, slot6.maxRacePlayerCount = slot2:GetMaxRaceData()
	slot6.targetEnemyID = slot2:GetTargetEnemyID()

	LuaExchangeHelper.SetIPAndPort(slot4, slot5)

	slot6.battleID = BattleFieldData:GetServerBattleID()
	slot6.Uuid = PlayerData:GetPlayerInfo().userID
	slot6.isMultiplayer = slot1
	slot6.nickName = PlayerData:GetPlayerInfo().nick
	slot6.VHLSkillID = slot2:GetActivityReforgeSkillList()
	slot6.VHLResult = slot2:GetBattleParams()
	slot20 = SettingData:GetSettingData()

	LuaExchangeHelper.SetPlayerQuality(slot20.pic.user_effect - 1)
	LuaExchangeHelper.SetAIQuality(slot20.pic.teammate_effect - 1)
	LuaExchangeHelper.SetCooperateUniqueSkillPlayControlledType(slot20.game.cus_full_play_controlled_type)

	slot21 = manager.time:GetServerTime()

	if slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		manager.story:CheckChessBattleStory(manager.story.BEFORE, function ()
			if manager.time:GetServerTime() - uv0 > 1500 then
				ConnectionHelper.ShowReturnToLoginTip()
				manager.story:RemovePlayer()

				return
			end

			uv1:TryToStartBattle()
		end)
	elseif slot23 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or slot23 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		manager.story:CheckBattleStory(slot2:GetStageId(), manager.story.BEFORE, slot22, false)
	else
		manager.story:CheckBattleStory(slot2:GetStageId(), manager.story.BEFORE, slot22)
	end

	BattleCallLuaCallBackWait = true
end

function slot0.TryToStartBattle(slot0)
	SetForceShowQuanquan(true)
	LuaExchangeHelper.Launcher(GetSceneDataForExcehange(), function ()
		SetForceShowQuanquan(false)
		manager.story:RemovePlayer()

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end, function ()
		gameContext:SetSystemLayer("battle")
	end)
end

function slot0.SetHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if slot2 and slot2 ~= 0 then
		slot5, slot6 = GetVirtualData(slot2)
	else
		slot5, slot6 = GetPracticalData(slot1)
	end

	slot8, slot9, slot10 = HeroTools.CalTransitionSkillAttribute(slot5, slot6)
	slot11 = RoleDataForExchange.New()
	slot11.UID = slot3
	slot11.playerLevel = slot4
	slot11.ID = slot5.using_skin
	slot11.Level = LvTools.CheckHeroExp(1, slot5.exp, HeroConst.HERO_LV_MAX)
	slot12 = {}
	slot13 = {}

	for slot17, slot18 in pairs(GetHeroFinalAttr(slot5, slot5.servantInfo, slot6, slot2)) do
		if PublicAttrCfg[slot17] then
			table.insert(slot12, slot19.id)
			table.insert(slot13, slot18)
		end
	end

	slot19 = slot5.weapon_module_level
	slot11.attributeID, slot11.attributeValue = BattleTools.FixBattleAttributeListAndWeaponModule(slot12, slot13, slot5.using_skin, slot19)
	slot14 = {}
	slot15 = {}

	for slot19, slot20 in pairs(slot9) do
		table.insert(slot14, slot19)
		table.insert(slot15, slot20)
	end

	slot11.equipSkillID = slot14
	slot11.equipSkillLv = slot15

	for slot21 = 1, 9 do
	end

	slot11.astrolabe = {
		[slot21] = AstrolabeTools.GetTotalEffect(slot5.using_astrolabe)[slot21] or 0
	}
	slot18 = {}

	for slot23, slot24 in pairs(EquipTools.GetEffectS(slot6, slot5)) do
		table.insert(slot18, slot23)
	end

	slot11.equipment = slot18
	slot20 = {}
	slot21 = HeroCfg[slot5.id]
	slot22 = {
		[slot27.skill_id] = slot27.skill_level
	}

	for slot26, slot27 in ipairs(slot5.skill) do
		-- Nothing
	end

	for slot26, slot27 in pairs(slot10) do
		slot22[slot26] = (slot22[slot26] or 1) + slot27
	end

	for slot26, slot27 in ipairs(slot21.skills) do
		slot20[slot26] = slot22[slot27] or 1
	end

	slot11.skillLevel = slot20

	if slot5.servantInfo and slot5.servantInfo.id ~= 0 then
		slot11.weaponEffectID = WeaponServantCfg[slot5.servantInfo.id].effect[1]
		slot11.weaponEffectLevel = slot5.servantInfo.stage + HeroTools.GetHeroWeaponAddLevel(slot5)
	end

	if (uv0:GetChipManagerID() or 0) ~= 0 then
		table.insert({}, slot24)
	end

	if uv0:GetChipOfHeroDic()[slot11.ID] then
		if slot24 ~= 0 then
			slot27 = ChipData
			slot29 = slot27

			for slot28, slot29 in ipairs(slot27.GetCurChipManagerList(slot29, slot24)) do
				table.insert(slot23, slot29)
			end
		end

		slot27 = uv0
		slot29 = slot27
		slot28 = slot11.ID

		for slot28, slot29 in ipairs(slot27.GetChipOfHeroDic(slot29)[slot28]) do
			table.insert(slot23, slot29)
		end
	elseif uv0:GetChipList() then
		for slot29, slot30 in ipairs(slot25) do
			table.insert(slot23, slot30)
		end
	end

	slot11.AIChip = slot23

	return slot11
end

function slot0.SetAdvanceTestHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if slot2 and slot2 ~= 0 then
		slot5, slot6 = GetVirtualData(slot2)
	else
		slot5, slot6 = GetPracticalData(slot1)
	end

	slot8, slot9, slot10 = HeroTools.CalTransitionSkillAttribute(slot5, slot6)
	slot11 = RoleDataForExchange.New()
	slot11.UID = slot3
	slot11.playerLevel = slot4
	slot11.ID = slot5.using_skin
	slot11.Level = LvTools.CheckHeroExp(1, slot5.exp, HeroConst.HERO_LV_MAX)
	slot12 = {}
	slot13 = {}

	for slot17, slot18 in pairs(GetHeroFinalAttr(slot5, slot5.servantInfo, slot6, slot2)) do
		if PublicAttrCfg[slot17] then
			table.insert(slot12, slot19.id)
			table.insert(slot13, slot18)
		end
	end

	slot19 = slot5.weapon_module_level
	slot11.attributeID, slot11.attributeValue = BattleTools.FixBattleAttributeListAndWeaponModule(slot12, slot13, slot5.using_skin, slot19)
	slot14 = {}
	slot15 = {}

	for slot19, slot20 in pairs(slot9) do
		table.insert(slot14, slot19)
		table.insert(slot15, slot20)
	end

	slot11.equipSkillID = slot14
	slot11.equipSkillLv = slot15

	for slot21 = 1, 9 do
	end

	slot11.astrolabe = {
		[slot21] = AstrolabeTools.GetTotalEffect(slot5.using_astrolabe)[slot21] or 0
	}
	slot18 = {}

	for slot23, slot24 in pairs(EquipTools.GetEffectS(slot6, slot5)) do
		table.insert(slot18, slot23)
	end

	slot11.equipment = slot18
	slot20 = {}
	slot21 = HeroCfg[slot5.id]
	slot22 = {
		[slot27.skill_id] = slot27.skill_level
	}

	for slot26, slot27 in ipairs(slot5.skill) do
		-- Nothing
	end

	for slot26, slot27 in pairs(slot10) do
		slot22[slot26] = (slot22[slot26] or 1) + slot27
	end

	for slot26, slot27 in ipairs(slot21.skills) do
		slot20[slot26] = slot22[slot27] or 1
	end

	slot11.skillLevel = slot20

	if slot5.servantInfo.id and slot5.servantInfo.id ~= 0 then
		slot11.weaponEffectID = WeaponServantCfg[slot5.servantInfo.id].effect[1]
		slot11.weaponEffectLevel = slot5.servantInfo.stage + HeroTools.GetHeroWeaponAddLevel(slot5)
	end

	if (uv0:GetChipManagerID() or 0) ~= 0 then
		table.insert({}, slot24)
	end

	if uv0:GetChipOfHeroDic()[slot11.ID] then
		if slot24 ~= 0 then
			slot27 = ChipData
			slot29 = slot27

			for slot28, slot29 in ipairs(slot27.GetCurChipManagerList(slot29, slot24)) do
				table.insert(slot23, slot29)
			end
		end

		slot27 = uv0
		slot29 = slot27
		slot28 = slot11.ID

		for slot28, slot29 in ipairs(slot27.GetChipOfHeroDic(slot29)[slot28]) do
			table.insert(slot23, slot29)
		end
	elseif uv0:GetChipList() then
		for slot29, slot30 in ipairs(slot25) do
			table.insert(slot23, slot30)
		end
	end

	slot11.AIChip = slot23

	return slot11
end

function slot0.SetMatrixHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1:GetStandardId()
	slot6, slot7 = nil

	if slot1:GetIsOwnerHero() then
		slot6, slot7 = GetPracticalData(slot1:GetEntrySnapShot())
	else
		slot6, slot7 = GetVirtualData(slot5)
	end

	slot8 = RoleDataForExchange.New()

	if slot4 then
		slot6.using_skin = ActivityMatrixData:GetHeroSkin(slot4, HeroStandardSystemCfg[slot5].hero_id)
	else
		slot6.using_skin = MatrixData:GetHeroSkin(slot9.hero_id)
	end

	slot8.UID = slot2
	slot8.playerLevel = slot3
	slot8.ID = slot6.using_skin
	slot8.Level = LvTools.CheckHeroExp(1, slot6.exp, HeroConst.HERO_LV_MAX)
	slot16 = slot1
	slot10 = GetMatrixtHeroPracticalAttr(slot6, slot7, slot5, slot4, slot16)
	slot10[3] = slot1:GetHeroMaxHP()
	slot10[2002] = slot1:GetHeroHP()
	slot11 = {}
	slot12 = {}

	for slot16, slot17 in pairs(slot10) do
		if PublicAttrCfg[slot16] or slot16 == 2002 then
			table.insert(slot11, slot16)
			table.insert(slot12, slot17)
		end
	end

	slot8.attributeID = slot11
	slot8.attributeValue = slot12

	for slot18 = 1, 9 do
	end

	slot8.astrolabe = {
		[slot18] = slot1:GetAstrolabeEffectList()[slot18] or 0
	}
	slot15 = {}
	slot8.equipment = slot1:GetEquipEffectList()
	slot17 = {}
	slot18 = HeroCfg[slot6.id]
	slot19 = {
		[slot24.skill_id] = slot24.skill_level
	}

	for slot23, slot24 in ipairs(slot6.skill) do
		-- Nothing
	end

	for slot23, slot24 in ipairs(slot18.skills) do
		slot17[slot23] = slot19[slot24] or 1
	end

	slot8.skillLevel = slot17

	if slot1:GetWeaponServantEffect() ~= 0 then
		slot8.weaponEffectID = WeaponServantCfg[slot20].effect[1]
		slot8.weaponEffectLevel = slot1:GetWeaponServantEffectLevel()
	end

	if uv0:GetChipManagerID() ~= 0 then
		slot26 = slot22

		table.insert({}, slot26)

		slot25 = uv0
		slot27 = slot25

		for slot26, slot27 in ipairs(slot25.GetChipList(slot27)) do
			table.insert(slot21, slot27)
		end
	end

	slot8.AIChip = slot21

	return slot8
end

function slot0.SetChessHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if slot2 and slot2 ~= 0 then
		slot5, slot6 = GetVirtualData(slot2)
	else
		slot5, slot6 = GetPracticalData(slot1)
	end

	slot8, slot9, slot10 = HeroTools.CalTransitionSkillAttribute(slot5, slot6)
	slot11 = RoleDataForExchange.New()
	slot11.UID = slot3
	slot11.playerLevel = slot4
	slot11.ID = slot5.using_skin
	slot11.Level = LvTools.CheckHeroExp(1, slot5.exp, HeroConst.HERO_LV_MAX)
	slot12 = {}
	slot13 = {}

	for slot17, slot18 in pairs(GetHeroFinalAttr(slot5, slot5.servantInfo, slot6, slot2)) do
		if PublicAttrCfg[slot17] or slot17 == 2002 then
			table.insert(slot12, slot17)
			table.insert(slot13, slot18)
		end
	end

	slot19 = slot5.weapon_module_level
	slot11.attributeID, slot11.attributeValue = BattleTools.FixBattleAttributeListAndWeaponModule(slot12, slot13, slot5.using_skin, slot19)
	slot14 = {}
	slot15 = {}

	for slot19, slot20 in pairs(slot9) do
		table.insert(slot14, slot19)
		table.insert(slot15, slot20)
	end

	slot11.equipSkillID = slot14
	slot11.equipSkillLv = slot15

	for slot21 = 1, 9 do
	end

	slot11.astrolabe = {
		[slot21] = AstrolabeTools.GetTotalEffect(slot5.using_astrolabe)[slot21] or 0
	}
	slot18 = {}

	for slot23, slot24 in pairs(EquipTools.GetEffectS(slot6, slot5)) do
		table.insert(slot18, slot23)
	end

	slot11.equipment = slot18
	slot20 = {}
	slot21 = HeroCfg[slot5.id]
	slot22 = {
		[slot27.skill_id] = slot27.skill_level
	}

	for slot26, slot27 in ipairs(slot5.skill) do
		-- Nothing
	end

	for slot26, slot27 in pairs(slot10) do
		slot22[slot26] = (slot22[slot26] or 1) + slot27
	end

	for slot26, slot27 in ipairs(slot21.skills) do
		slot20[slot26] = slot22[slot27] or 1
	end

	slot11.skillLevel = slot20

	if slot5.servantInfo.id and slot5.servantInfo.id ~= 0 then
		slot11.weaponEffectID = WeaponServantCfg[slot5.servantInfo.id].effect[1]
		slot11.weaponEffectLevel = slot5.servantInfo.stage + HeroTools.GetHeroWeaponAddLevel(slot5)
	end

	if uv0:GetChipManagerID() ~= 0 then
		table.insert({}, slot24)
	end

	if uv0:GetChipOfHeroDic()[slot11.ID] then
		if slot24 ~= 0 then
			slot27 = ChipData
			slot29 = slot27

			for slot28, slot29 in ipairs(slot27.GetCurChipManagerList(slot29, slot24)) do
				table.insert(slot23, slot29)
			end
		end

		slot27 = uv0
		slot29 = slot27
		slot28 = slot11.ID

		for slot28, slot29 in ipairs(slot27.GetChipOfHeroDic(slot29)[slot28]) do
			table.insert(slot23, slot29)
		end
	elseif uv0:GetChipList() then
		for slot29, slot30 in ipairs(slot25) do
			table.insert(slot23, slot30)
		end
	end

	slot11.AIChip = slot23

	return slot11
end

function slot0.SetEquipBreakThroughMaterialHeroData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = nil

	if slot3 and slot3 ~= 0 then
		slot6, slot7 = GetVirtualData(slot3)
	else
		slot6, slot7 = GetPracticalData(slot2)
	end

	slot8 = GetHeroFinalAttr(slot6, slot6.servantInfo, slot7, slot3)
	slot9, slot10, slot11 = HeroTools.CalTransitionSkillAttribute(slot6, slot7)
	slot12 = RoleDataForExchange.New()
	slot12.UID = slot4
	slot12.playerLevel = slot5
	slot12.ID = slot6.using_skin
	slot12.Level = LvTools.CheckHeroExp(1, slot6.exp, HeroConst.HERO_LV_MAX)
	slot13 = {}
	slot14 = {}

	if EquipBreakThroughMaterialData:GetHeroState()[slot1] and EquipBreakThroughMaterialData:GetHeroState()[slot1].rate or 10000 then
		slot8[2002] = math.ceil(slot15 / 10000 * slot8[3])
	end

	for slot19, slot20 in pairs(slot8) do
		if PublicAttrCfg[slot19] or slot19 == 2002 then
			table.insert(slot13, slot19)
			table.insert(slot14, slot20)
		end
	end

	slot21 = slot6.weapon_module_level
	slot12.attributeID, slot12.attributeValue = BattleTools.FixBattleAttributeListAndWeaponModule(slot13, slot14, slot6.using_skin, slot21)
	slot16 = {}
	slot17 = {}

	for slot21, slot22 in pairs(slot10) do
		table.insert(slot16, slot21)
		table.insert(slot17, slot22)
	end

	slot12.equipSkillID = slot16
	slot12.equipSkillLv = slot17

	for slot23 = 1, 9 do
	end

	slot12.astrolabe = {
		[slot23] = AstrolabeTools.GetTotalEffect(slot6.using_astrolabe)[slot23] or 0
	}
	slot20 = {}

	for slot25, slot26 in pairs(EquipTools.GetEffectS(slot7, slot6)) do
		table.insert(slot20, slot25)
	end

	slot12.equipment = slot20
	slot22 = {}
	slot23 = HeroCfg[slot6.id]
	slot24 = {
		[slot29.skill_id] = slot29.skill_level
	}

	for slot28, slot29 in ipairs(slot6.skill) do
		-- Nothing
	end

	for slot28, slot29 in pairs(slot11) do
		slot24[slot28] = (slot24[slot28] or 1) + slot29
	end

	for slot28, slot29 in ipairs(slot23.skills) do
		slot22[slot28] = slot24[slot29] or 1
	end

	slot12.skillLevel = slot22

	if slot6.servantInfo.id and slot6.servantInfo.id ~= 0 then
		slot12.weaponEffectID = WeaponServantCfg[slot6.servantInfo.id].effect[1]
		slot12.weaponEffectLevel = slot6.servantInfo.stage + HeroTools.GetHeroWeaponAddLevel(slot6)
	end

	slot12.AIChip = uv0:GetChipAndAIList(slot12.ID)

	return slot12
end

function slot0.SetPolyhedronHeroData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = nil

	if slot2 == nil then
		slot6, slot7 = GetVirtualData(slot3)
	else
		slot6, slot7 = slot2:GetVirtualData()
	end

	slot8 = GetPolyhedronHeroPracticalAttr(slot1, slot6, slot7, slot3)
	slot9, slot10, slot11 = HeroTools.CalTransitionSkillAttribute(slot6, slot7)
	slot12 = RoleDataForExchange.New()
	slot12.UID = slot4
	slot12.playerLevel = slot5
	slot12.ID = PolyhedronData:GetHeroUsingSkinInfo(slot6.id).id
	slot12.Level = LvTools.CheckHeroExp(1, slot6.exp, HeroConst.HERO_LV_MAX)
	slot13 = {}
	slot14 = {}
	slot16 = slot1:GetHeroPolyData(slot6.id)
	slot8[3] = slot16:GetHeroMaxHP()
	slot20 = slot16
	slot8[2002] = slot16.GetHeroHP(slot20)

	for slot20, slot21 in pairs(slot8) do
		if PublicAttrCfg[slot20] or slot20 == 2002 then
			table.insert(slot13, slot20)
			table.insert(slot14, slot21)
		end
	end

	slot12.attributeID = slot13
	slot12.attributeValue = slot14
	slot17 = {}
	slot18 = {}

	for slot22, slot23 in pairs(slot10) do
		table.insert(slot17, slot22)
		table.insert(slot18, slot23)
	end

	slot12.equipSkillID = slot17
	slot12.equipSkillLv = slot18

	for slot24 = 1, 9 do
	end

	slot12.astrolabe = {
		[slot24] = AstrolabeTools.GetTotalEffect(slot6.using_astrolabe)[slot24] or 0
	}
	slot21 = {}

	for slot26, slot27 in pairs(EquipTools.GetEffectS(slot7, slot6)) do
		table.insert(slot21, slot26)
	end

	slot12.equipment = slot21
	slot23 = {}
	slot24 = HeroCfg[slot6.id]
	slot25 = {
		[slot30.skill_id] = slot30.skill_level
	}

	for slot29, slot30 in ipairs(slot6.skill) do
		-- Nothing
	end

	for slot29, slot30 in pairs(slot11) do
		slot25[slot29] = (slot25[slot29] or 1) + slot30
	end

	for slot29, slot30 in ipairs(slot24.skills) do
		slot23[slot29] = slot25[slot30] or 1
	end

	slot12.skillLevel = slot23

	if slot6.servantInfo.id and slot6.servantInfo.id ~= 0 then
		slot12.weaponEffectID = WeaponServantCfg[slot6.servantInfo.id].effect[1]
		slot12.weaponEffectLevel = slot6.servantInfo.stage + HeroTools.GetHeroWeaponAddLevel(slot6)
	end

	slot12.AIChip = {}

	return slot12
end

function slot0.SetNewWarChessHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if slot2 and slot2 ~= 0 then
		slot5, slot6 = GetVirtualData(slot2)
	else
		slot5, slot6 = GetPracticalData(slot1)
	end

	slot7 = GetHeroFinalAttr(slot5, slot5.servantInfo, slot6, slot2)
	slot8, slot9, slot10 = HeroTools.CalTransitionSkillAttribute(slot5, slot6)
	slot11 = RoleDataForExchange.New()
	slot11.UID = slot3
	slot11.playerLevel = slot4
	slot11.ID = slot5.using_skin
	slot11.Level = LvTools.CheckHeroExp(1, slot5.exp, HeroConst.HERO_LV_MAX)
	slot16 = NewWarChessData
	slot18 = slot16
	slot19 = slot5.id
	slot7[2002] = math.ceil(slot16.GetHeroHp(slot18, slot19) / NewChessConst.HERO_HP_RATE * slot7[3])
	slot13 = {}
	slot14 = {}

	for slot18, slot19 in pairs(slot7) do
		if PublicAttrCfg[slot18] or slot18 == 2002 then
			table.insert(slot13, slot18)
			table.insert(slot14, slot19)
		end
	end

	slot20 = slot5.weapon_module_level
	slot11.attributeID, slot11.attributeValue = BattleTools.FixBattleAttributeListAndWeaponModule(slot13, slot14, slot5.using_skin, slot20)
	slot15 = {}
	slot16 = {}

	for slot20, slot21 in pairs(slot9) do
		table.insert(slot15, slot20)
		table.insert(slot16, slot21)
	end

	slot11.equipSkillID = slot15
	slot11.equipSkillLv = slot16

	for slot22 = 1, 9 do
	end

	slot11.astrolabe = {
		[slot22] = AstrolabeTools.GetTotalEffect(slot5.using_astrolabe)[slot22] or 0
	}
	slot19 = {}

	for slot24, slot25 in pairs(EquipTools.GetEffectS(slot6, slot5)) do
		table.insert(slot19, slot24)
	end

	slot11.equipment = slot19
	slot21 = {}
	slot22 = HeroCfg[slot5.id]
	slot23 = {
		[slot28.skill_id] = slot28.skill_level
	}

	for slot27, slot28 in ipairs(slot5.skill) do
		-- Nothing
	end

	for slot27, slot28 in pairs(slot10) do
		slot23[slot27] = (slot23[slot27] or 1) + slot28
	end

	for slot27, slot28 in ipairs(slot22.skills) do
		slot21[slot27] = slot23[slot28] or 1
	end

	slot11.skillLevel = slot21

	if slot5.servantInfo.id and slot5.servantInfo.id ~= 0 then
		slot11.weaponEffectID = WeaponServantCfg[slot5.servantInfo.id].effect[1]
		slot11.weaponEffectLevel = slot5.servantInfo.stage + HeroTools.GetHeroWeaponAddLevel(slot5)
	end

	if (uv0:GetChipManagerID() or 0) ~= 0 then
		table.insert({}, slot25)
	end

	if uv0:GetChipOfHeroDic()[slot11.ID] then
		if slot25 ~= 0 then
			slot28 = ChipData
			slot30 = slot28

			for slot29, slot30 in ipairs(slot28.GetCurChipManagerList(slot30, slot25)) do
				table.insert(slot24, slot30)
			end
		end

		slot28 = uv0
		slot30 = slot28
		slot29 = slot11.ID

		for slot29, slot30 in ipairs(slot28.GetChipOfHeroDic(slot30)[slot29]) do
			table.insert(slot24, slot30)
		end
	elseif uv0:GetChipList() then
		for slot30, slot31 in ipairs(slot26) do
			table.insert(slot24, slot31)
		end
	end

	slot11.AIChip = slot24

	return slot11
end

return slot0
