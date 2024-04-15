local var_0_0 = singletonClass("BattleController")
local var_0_1
local var_0_2

function var_0_0.GetBattleStageData(arg_1_0)
	return var_0_1
end

function var_0_0.GetRoomProxy(arg_2_0)
	return var_0_2
end

function var_0_0.ClearRoomProxy(arg_3_0)
	var_0_2 = nil
end

function var_0_0.SetBattleStageData(arg_4_0, arg_4_1)
	var_0_1 = arg_4_1
end

function var_0_0.LaunchBattle(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	WaitStartBattle = nil

	local var_5_0 = arg_5_1:GetType()
	local var_5_1 = arg_5_1:GetDest()
	local var_5_2 = arg_5_1:GetMultiple()
	local var_5_3 = arg_5_1:GetType()
	local var_5_4, var_5_5 = arg_5_1:GetHeroTeam()
	local var_5_6 = arg_5_1:GetAssistHeroOwnerList()
	local var_5_7 = clone(var_5_4)
	local var_5_8 = clone(var_5_5)

	for iter_5_0 = #var_5_7, 1, -1 do
		if var_5_7[iter_5_0] == 0 then
			table.remove(var_5_7, iter_5_0)
			table.remove(var_5_8, iter_5_0)
		end
	end

	for iter_5_1 = 1, 2 do
		for iter_5_2 = iter_5_1 + 1, 3 do
			if var_5_7[iter_5_1] and var_5_7[iter_5_2] and var_5_7[iter_5_1] ~= 0 and var_5_7[iter_5_1] == var_5_7[iter_5_2] then
				ShowTips("TEAM_REPEAT_HERO")

				return
			end
		end
	end

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_5_3 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == var_5_3 then
		var_5_7 = arg_5_1:GetSystemHeroTeam()

		local var_5_9 = var_5_7
	end

	local var_5_10 = arg_5_1:GetComboSkillID() or 0
	local var_5_11 = arg_5_1:GetSystemHeroTeam()
	local var_5_12 = {}

	for iter_5_3, iter_5_4 in ipairs(var_5_7) do
		var_5_12[iter_5_3] = {}

		if var_5_5[iter_5_3] ~= 0 and var_5_5[iter_5_3] ~= nil then
			var_5_12[iter_5_3].hero_type = 2
			var_5_12[iter_5_3].owner_id = BattleTeamData.NO_OWNER
			var_5_12[iter_5_3].hero_id = var_5_5[iter_5_3]
		elseif var_5_11[iter_5_3] ~= 0 and var_5_11[iter_5_3] ~= nil then
			var_5_12[iter_5_3].hero_type = 2
			var_5_12[iter_5_3].owner_id = BattleTeamData.NO_OWNER
			var_5_12[iter_5_3].hero_id = var_5_11[iter_5_3]
		else
			var_5_12[iter_5_3].hero_id = var_5_7[iter_5_3]
			var_5_12[iter_5_3].owner_id = var_5_6[iter_5_3] or BattleTeamData.NO_OWNER
			var_5_12[iter_5_3].hero_type = not BattleTeamData.IsValidOwner(var_5_12[iter_5_3].owner_id) and 1 or 3
		end
	end

	manager.net:SendWithLoadingNew(54030, {
		hero_list = var_5_12,
		dest = var_5_1,
		activity_id = arg_5_1:GetActivityID() or 0,
		battle_times = var_5_2,
		type = var_5_3,
		index = arg_5_1:GetServerExtant(),
		cooperate_unique_skill_id = var_5_10,
		battle_vs = LuaForUtil.GetBattleVersion(),
		mimir_info = {
			{
				mimir_id = arg_5_1:GetChipManagerID(),
				chip_list = arg_5_1:GetChipList()
			}
		}
	}, 54031, function(arg_6_0)
		if arg_5_3 then
			arg_5_3(arg_6_0)
		end

		if isSuccess(arg_6_0.result) then
			var_0_1 = arg_5_1
			var_0_2 = arg_5_2

			manager.net:RegistPushWaiting(54007, function()
				return
			end)
		elseif arg_6_0.result == 2109 and BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == var_5_3 then
			ShowTips(300114)
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.LaunchCooperationBattle(arg_8_0)
	manager.net:SendWithLoadingNew(37014, {}, 37015, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			WaitStartBattle = nil
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

function var_0_0.LaunchCooperationBattleWithoutRoom(arg_10_0, arg_10_1)
	local var_10_0 = BattleStageFactory.Produce(arg_10_1.battle_type, arg_10_1.dest, {
		dest = arg_10_1.dest,
		activityID = arg_10_1.activity_id
	})

	BattleController.GetInstance():SetBattleStageData(var_10_0)
	var_10_0:UpdateRoleDatas()
	BattleFieldData:SetServerBattleParams(arg_10_1.battle_id, arg_10_1.server_ip, arg_10_1.server_port)
	BattleController.GetInstance():StartBattle(true)
end

function var_0_0.LaunchStoryBattle(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	manager.story:CheckBattleStory(arg_11_2, manager.story.BEFORE, function()
		gameContext:Go("/blank")
		manager.net:SendWithLoadingNew(54034, {
			stage_id = arg_11_2,
			activity_id = arg_11_3
		}, 54035, function(arg_13_0)
			if isSuccess(arg_13_0.result) then
				var_0_1 = BattleStageFactory.Produce(arg_11_1, arg_11_2, arg_11_3)

				var_0_1:SetIsStoryTag(true)

				local var_13_0 = arg_13_0.battle_id
				local var_13_1 = GetOldPlayerExp()

				manager.net:SendWithLoadingNew(54032, {
					battle_id = var_13_0
				}, 54033, function(arg_14_0, arg_14_1)
					manager.story:RemovePlayer()
					BattleFieldData:FinishBattle(arg_14_0)

					BattleCallLuaCallBackWait = false
					BattleCallLuaWaitLoading = false

					GotoTeam(var_13_0, arg_14_0.battle_result, arg_14_0.result, var_13_1)
				end)
			else
				ShowTips(arg_13_0.result)
				manager.story:RemovePlayer()
			end
		end)
	end, false)
end

function var_0_0.UpdateHeroTeam(arg_15_0, arg_15_1)
	if not var_0_1 then
		error("Loss Current BattleStageData In UpdateHeroTeam")

		return
	end

	var_0_1:UpdateRoleDatas(arg_15_1)
end

function var_0_0.StartBattle(arg_16_0, arg_16_1)
	if not var_0_1 then
		error("Loss Current BattleStageData In StartBattle")

		return
	end

	local var_16_0 = var_0_1
	local var_16_1 = BattleFieldData:GetServerBattleID()
	local var_16_2, var_16_3 = BattleFieldData:GetBattleServerIPAndPort()
	local var_16_4 = GetSceneDataForExcehange()

	var_16_4.leftTime = var_16_0:GetBattleTime() * 1000

	local var_16_5, var_16_6, var_16_7 = var_16_0:GetBattleStageAffix()

	var_16_4.typeIDListAffix = var_16_5
	var_16_4.levelList = var_16_6
	var_16_4.enemyTypes = var_16_7

	local var_16_8, var_16_9 = var_16_0:GetMap()

	LuaExchangeHelper.SetNewbie(var_16_9)

	var_16_4.mSceneID = var_16_8

	local var_16_10, var_16_11, var_16_12, var_16_13, var_16_14 = var_16_0:GetRevive()

	var_16_4.needResurrect = var_16_10
	var_16_4.coinNumber = var_16_12
	var_16_4.coinConsume = var_16_13
	var_16_4.maxCoinNumber = var_16_14 or 0
	var_16_4.resurrectHP = var_16_0:GetResurrectHP()
	var_16_4.resurrectImmediately = var_16_0:GetResurrectImmediately()
	var_16_4.challengeFactor = var_16_0:GetMultiple()
	var_16_4.mMissionClearTimes = var_16_0:GetClearTime()
	var_16_4.difficulty = var_16_0:GetAILevel()
	var_16_4.adaptiveEnemyLevel = var_16_0:GetEnemyLevel()
	var_16_4.roleDataInLua = var_16_0:GetRoleDatas()

	local var_16_15 = var_16_0:GetAttributeFactor()

	var_16_4.attributeFactor = Int3.New(var_16_15.x * 1000, var_16_15.y * 1000, var_16_15.z * 1000)
	var_16_4.cooperateUniqueSkillID = var_16_0:GetComboSkillID()
	var_16_4.cooperateUniqueSkillLevel = var_16_0:GetComboSkillLevel()

	local var_16_16, var_16_17 = var_16_0:GetMaxRaceData()

	var_16_4.maxRaceID = var_16_16
	var_16_4.maxRacePlayerCount = var_16_17
	var_16_4.targetEnemyID = var_16_0:GetTargetEnemyID()

	LuaExchangeHelper.SetIPAndPort(var_16_2, var_16_3)

	var_16_4.battleID = var_16_1
	var_16_4.Uuid = PlayerData:GetPlayerInfo().userID
	var_16_4.isMultiplayer = arg_16_1
	var_16_4.nickName = PlayerData:GetPlayerInfo().nick
	var_16_4.VHLSkillID = var_16_0:GetActivityReforgeSkillList()
	var_16_4.VHLResult = var_16_0:GetBattleParams()

	local var_16_18 = SettingData:GetSettingData()

	LuaExchangeHelper.SetPlayerQuality(var_16_18.pic.user_effect - 1)
	LuaExchangeHelper.SetAIQuality(var_16_18.pic.teammate_effect - 1)
	LuaExchangeHelper.SetCooperateUniqueSkillPlayControlledType(var_16_18.game.cus_full_play_controlled_type)

	local var_16_19 = manager.time:GetServerTime()

	local function var_16_20()
		if manager.time:GetServerTime() - var_16_19 > 1500 then
			ConnectionHelper.ShowReturnToLoginTip()
			manager.story:RemovePlayer()

			return
		end

		arg_16_0:TryToStartBattle()
	end

	local var_16_21 = var_16_0:GetType()

	if var_16_21 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		manager.story:CheckChessBattleStory(manager.story.BEFORE, var_16_20)
	elseif var_16_21 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_16_21 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		local var_16_22 = var_16_0:GetStageId()

		manager.story:CheckBattleStory(var_16_22, manager.story.BEFORE, var_16_20, false)
	else
		local var_16_23 = var_16_0:GetStageId()

		manager.story:CheckBattleStory(var_16_23, manager.story.BEFORE, var_16_20)
	end

	BattleCallLuaCallBackWait = true
end

function var_0_0.TryToStartBattle(arg_18_0)
	SetForceShowQuanquan(true)
	LuaExchangeHelper.Launcher(GetSceneDataForExcehange(), function()
		SetForceShowQuanquan(false)
		manager.story:RemovePlayer()

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end, function()
		gameContext:SetSystemLayer("battle")
	end)
end

function var_0_0.SetHeroData(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0
	local var_21_1

	if arg_21_2 and arg_21_2 ~= 0 then
		var_21_0, var_21_1 = GetVirtualData(arg_21_2)
	else
		var_21_0, var_21_1 = GetPracticalData(arg_21_1)
	end

	local var_21_2 = GetHeroFinalAttr(var_21_0, var_21_0.servantInfo, var_21_1, arg_21_2)
	local var_21_3, var_21_4, var_21_5 = HeroTools.CalTransitionSkillAttribute(var_21_0, var_21_1)
	local var_21_6 = RoleDataForExchange.New()

	var_21_6.UID = arg_21_3
	var_21_6.playerLevel = arg_21_4
	var_21_6.ID = var_21_0.using_skin
	var_21_6.Level = LvTools.CheckHeroExp(1, var_21_0.exp, HeroConst.HERO_LV_MAX)

	local var_21_7 = {}
	local var_21_8 = {}

	for iter_21_0, iter_21_1 in pairs(var_21_2) do
		local var_21_9 = PublicAttrCfg[iter_21_0]

		if var_21_9 then
			table.insert(var_21_7, var_21_9.id)
			table.insert(var_21_8, iter_21_1)
		end
	end

	local var_21_10, var_21_11 = BattleTools.FixBattleAttributeListAndWeaponModule(var_21_7, var_21_8, var_21_0.using_skin, var_21_0.weapon_module_level)

	var_21_6.attributeValue, var_21_6.attributeID = var_21_11, var_21_10

	local var_21_12 = {}
	local var_21_13 = {}

	for iter_21_2, iter_21_3 in pairs(var_21_4) do
		table.insert(var_21_12, iter_21_2)
		table.insert(var_21_13, iter_21_3)
	end

	var_21_6.equipSkillID = var_21_12
	var_21_6.equipSkillLv = var_21_13

	local var_21_14 = {}
	local var_21_15 = AstrolabeTools.GetTotalEffect(var_21_0.using_astrolabe)

	for iter_21_4 = 1, 9 do
		var_21_14[iter_21_4] = var_21_15[iter_21_4] or 0
	end

	var_21_6.astrolabe = var_21_14

	local var_21_16 = {}
	local var_21_17 = EquipTools.GetEffectS(var_21_1, var_21_0)

	for iter_21_5, iter_21_6 in pairs(var_21_17) do
		table.insert(var_21_16, iter_21_5)
	end

	var_21_6.equipment = var_21_16

	local var_21_18 = {}
	local var_21_19 = HeroCfg[var_21_0.id]
	local var_21_20 = {}

	for iter_21_7, iter_21_8 in ipairs(var_21_0.skill) do
		var_21_20[iter_21_8.skill_id] = iter_21_8.skill_level
	end

	for iter_21_9, iter_21_10 in pairs(var_21_5) do
		var_21_20[iter_21_9] = (var_21_20[iter_21_9] or 1) + iter_21_10
	end

	for iter_21_11, iter_21_12 in ipairs(var_21_19.skills) do
		var_21_18[iter_21_11] = var_21_20[iter_21_12] or 1
	end

	var_21_6.skillLevel = var_21_18

	if var_21_0.servantInfo and var_21_0.servantInfo.id ~= 0 then
		local var_21_21 = HeroTools.GetHeroWeaponAddLevel(var_21_0)

		var_21_6.weaponEffectID = WeaponServantCfg[var_21_0.servantInfo.id].effect[1]
		var_21_6.weaponEffectLevel = var_21_0.servantInfo.stage + var_21_21
	end

	local var_21_22 = {}
	local var_21_23 = var_0_1:GetChipManagerID() or 0

	if var_21_23 ~= 0 then
		table.insert(var_21_22, var_21_23)
	end

	if var_0_1:GetChipOfHeroDic()[var_21_6.ID] then
		if var_21_23 ~= 0 then
			for iter_21_13, iter_21_14 in ipairs(ChipData:GetCurChipManagerList(var_21_23)) do
				table.insert(var_21_22, iter_21_14)
			end
		end

		for iter_21_15, iter_21_16 in ipairs(var_0_1:GetChipOfHeroDic()[var_21_6.ID]) do
			table.insert(var_21_22, iter_21_16)
		end
	else
		local var_21_24 = var_0_1:GetChipList()

		if var_21_24 then
			for iter_21_17, iter_21_18 in ipairs(var_21_24) do
				table.insert(var_21_22, iter_21_18)
			end
		end
	end

	var_21_6.AIChip = var_21_22

	return var_21_6
end

function var_0_0.SetAdvanceTestHeroData(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0
	local var_22_1

	if arg_22_2 and arg_22_2 ~= 0 then
		var_22_0, var_22_1 = GetVirtualData(arg_22_2)
	else
		var_22_0, var_22_1 = GetPracticalData(arg_22_1)
	end

	local var_22_2 = GetHeroFinalAttr(var_22_0, var_22_0.servantInfo, var_22_1, arg_22_2)
	local var_22_3, var_22_4, var_22_5 = HeroTools.CalTransitionSkillAttribute(var_22_0, var_22_1)
	local var_22_6 = RoleDataForExchange.New()

	var_22_6.UID = arg_22_3
	var_22_6.playerLevel = arg_22_4
	var_22_6.ID = var_22_0.using_skin
	var_22_6.Level = LvTools.CheckHeroExp(1, var_22_0.exp, HeroConst.HERO_LV_MAX)

	local var_22_7 = {}
	local var_22_8 = {}

	for iter_22_0, iter_22_1 in pairs(var_22_2) do
		local var_22_9 = PublicAttrCfg[iter_22_0]

		if var_22_9 then
			table.insert(var_22_7, var_22_9.id)
			table.insert(var_22_8, iter_22_1)
		end
	end

	local var_22_10, var_22_11 = BattleTools.FixBattleAttributeListAndWeaponModule(var_22_7, var_22_8, var_22_0.using_skin, var_22_0.weapon_module_level)

	var_22_6.attributeValue, var_22_6.attributeID = var_22_11, var_22_10

	local var_22_12 = {}
	local var_22_13 = {}

	for iter_22_2, iter_22_3 in pairs(var_22_4) do
		table.insert(var_22_12, iter_22_2)
		table.insert(var_22_13, iter_22_3)
	end

	var_22_6.equipSkillID = var_22_12
	var_22_6.equipSkillLv = var_22_13

	local var_22_14 = {}
	local var_22_15 = AstrolabeTools.GetTotalEffect(var_22_0.using_astrolabe)

	for iter_22_4 = 1, 9 do
		var_22_14[iter_22_4] = var_22_15[iter_22_4] or 0
	end

	var_22_6.astrolabe = var_22_14

	local var_22_16 = {}
	local var_22_17 = EquipTools.GetEffectS(var_22_1, var_22_0)

	for iter_22_5, iter_22_6 in pairs(var_22_17) do
		table.insert(var_22_16, iter_22_5)
	end

	var_22_6.equipment = var_22_16

	local var_22_18 = {}
	local var_22_19 = HeroCfg[var_22_0.id]
	local var_22_20 = {}

	for iter_22_7, iter_22_8 in ipairs(var_22_0.skill) do
		var_22_20[iter_22_8.skill_id] = iter_22_8.skill_level
	end

	for iter_22_9, iter_22_10 in pairs(var_22_5) do
		var_22_20[iter_22_9] = (var_22_20[iter_22_9] or 1) + iter_22_10
	end

	for iter_22_11, iter_22_12 in ipairs(var_22_19.skills) do
		var_22_18[iter_22_11] = var_22_20[iter_22_12] or 1
	end

	var_22_6.skillLevel = var_22_18

	if var_22_0.servantInfo.id and var_22_0.servantInfo.id ~= 0 then
		local var_22_21 = HeroTools.GetHeroWeaponAddLevel(var_22_0)

		var_22_6.weaponEffectID = WeaponServantCfg[var_22_0.servantInfo.id].effect[1]
		var_22_6.weaponEffectLevel = var_22_0.servantInfo.stage + var_22_21
	end

	local var_22_22 = {}
	local var_22_23 = var_0_1:GetChipManagerID() or 0

	if var_22_23 ~= 0 then
		table.insert(var_22_22, var_22_23)
	end

	if var_0_1:GetChipOfHeroDic()[var_22_6.ID] then
		if var_22_23 ~= 0 then
			for iter_22_13, iter_22_14 in ipairs(ChipData:GetCurChipManagerList(var_22_23)) do
				table.insert(var_22_22, iter_22_14)
			end
		end

		for iter_22_15, iter_22_16 in ipairs(var_0_1:GetChipOfHeroDic()[var_22_6.ID]) do
			table.insert(var_22_22, iter_22_16)
		end
	else
		local var_22_24 = var_0_1:GetChipList()

		if var_22_24 then
			for iter_22_17, iter_22_18 in ipairs(var_22_24) do
				table.insert(var_22_22, iter_22_18)
			end
		end
	end

	var_22_6.AIChip = var_22_22

	return var_22_6
end

function var_0_0.SetMatrixHeroData(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_1:GetStandardId()
	local var_23_1
	local var_23_2

	if arg_23_1:GetIsOwnerHero() then
		var_23_1, var_23_2 = GetPracticalData(arg_23_1:GetEntrySnapShot())
	else
		var_23_1, var_23_2 = GetVirtualData(var_23_0)
	end

	local var_23_3 = RoleDataForExchange.New()
	local var_23_4 = HeroStandardSystemCfg[var_23_0]

	if arg_23_4 then
		var_23_1.using_skin = ActivityMatrixData:GetHeroSkin(arg_23_4, var_23_4.hero_id)
	else
		var_23_1.using_skin = MatrixData:GetHeroSkin(var_23_4.hero_id)
	end

	var_23_3.UID = arg_23_2
	var_23_3.playerLevel = arg_23_3
	var_23_3.ID = var_23_1.using_skin
	var_23_3.Level = LvTools.CheckHeroExp(1, var_23_1.exp, HeroConst.HERO_LV_MAX)

	local var_23_5 = GetMatrixtHeroPracticalAttr(var_23_1, var_23_2, var_23_0, arg_23_4, arg_23_1)

	var_23_5[3] = arg_23_1:GetHeroMaxHP()
	var_23_5[2002] = arg_23_1:GetHeroHP()

	local var_23_6 = {}
	local var_23_7 = {}

	for iter_23_0, iter_23_1 in pairs(var_23_5) do
		if PublicAttrCfg[iter_23_0] or iter_23_0 == 2002 then
			table.insert(var_23_6, iter_23_0)
			table.insert(var_23_7, iter_23_1)
		end
	end

	var_23_3.attributeID = var_23_6
	var_23_3.attributeValue = var_23_7

	local var_23_8 = {}
	local var_23_9 = arg_23_1:GetAstrolabeEffectList()

	for iter_23_2 = 1, 9 do
		var_23_8[iter_23_2] = var_23_9[iter_23_2] or 0
	end

	var_23_3.astrolabe = var_23_8

	local var_23_10 = {}

	var_23_3.equipment = arg_23_1:GetEquipEffectList()

	local var_23_11 = {}
	local var_23_12 = HeroCfg[var_23_1.id]
	local var_23_13 = {}

	for iter_23_3, iter_23_4 in ipairs(var_23_1.skill) do
		var_23_13[iter_23_4.skill_id] = iter_23_4.skill_level
	end

	for iter_23_5, iter_23_6 in ipairs(var_23_12.skills) do
		var_23_11[iter_23_5] = var_23_13[iter_23_6] or 1
	end

	var_23_3.skillLevel = var_23_11

	local var_23_14 = arg_23_1:GetWeaponServantEffect()

	if var_23_14 ~= 0 then
		var_23_3.weaponEffectID = WeaponServantCfg[var_23_14].effect[1]
		var_23_3.weaponEffectLevel = arg_23_1:GetWeaponServantEffectLevel()
	end

	local var_23_15 = {}
	local var_23_16 = var_0_1:GetChipManagerID()

	if var_23_16 ~= 0 then
		table.insert(var_23_15, var_23_16)

		for iter_23_7, iter_23_8 in ipairs(var_0_1:GetChipList()) do
			table.insert(var_23_15, iter_23_8)
		end
	end

	var_23_3.AIChip = var_23_15

	return var_23_3
end

function var_0_0.SetChessHeroData(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0
	local var_24_1

	if arg_24_2 and arg_24_2 ~= 0 then
		var_24_0, var_24_1 = GetVirtualData(arg_24_2)
	else
		var_24_0, var_24_1 = GetPracticalData(arg_24_1)
	end

	local var_24_2 = GetHeroFinalAttr(var_24_0, var_24_0.servantInfo, var_24_1, arg_24_2)
	local var_24_3, var_24_4, var_24_5 = HeroTools.CalTransitionSkillAttribute(var_24_0, var_24_1)
	local var_24_6 = RoleDataForExchange.New()

	var_24_6.UID = arg_24_3
	var_24_6.playerLevel = arg_24_4
	var_24_6.ID = var_24_0.using_skin
	var_24_6.Level = LvTools.CheckHeroExp(1, var_24_0.exp, HeroConst.HERO_LV_MAX)

	local var_24_7 = {}
	local var_24_8 = {}

	for iter_24_0, iter_24_1 in pairs(var_24_2) do
		if PublicAttrCfg[iter_24_0] or iter_24_0 == 2002 then
			table.insert(var_24_7, iter_24_0)
			table.insert(var_24_8, iter_24_1)
		end
	end

	local var_24_9, var_24_10 = BattleTools.FixBattleAttributeListAndWeaponModule(var_24_7, var_24_8, var_24_0.using_skin, var_24_0.weapon_module_level)

	var_24_6.attributeValue, var_24_6.attributeID = var_24_10, var_24_9

	local var_24_11 = {}
	local var_24_12 = {}

	for iter_24_2, iter_24_3 in pairs(var_24_4) do
		table.insert(var_24_11, iter_24_2)
		table.insert(var_24_12, iter_24_3)
	end

	var_24_6.equipSkillID = var_24_11
	var_24_6.equipSkillLv = var_24_12

	local var_24_13 = {}
	local var_24_14 = AstrolabeTools.GetTotalEffect(var_24_0.using_astrolabe)

	for iter_24_4 = 1, 9 do
		var_24_13[iter_24_4] = var_24_14[iter_24_4] or 0
	end

	var_24_6.astrolabe = var_24_13

	local var_24_15 = {}
	local var_24_16 = EquipTools.GetEffectS(var_24_1, var_24_0)

	for iter_24_5, iter_24_6 in pairs(var_24_16) do
		table.insert(var_24_15, iter_24_5)
	end

	var_24_6.equipment = var_24_15

	local var_24_17 = {}
	local var_24_18 = HeroCfg[var_24_0.id]
	local var_24_19 = {}

	for iter_24_7, iter_24_8 in ipairs(var_24_0.skill) do
		var_24_19[iter_24_8.skill_id] = iter_24_8.skill_level
	end

	for iter_24_9, iter_24_10 in pairs(var_24_5) do
		var_24_19[iter_24_9] = (var_24_19[iter_24_9] or 1) + iter_24_10
	end

	for iter_24_11, iter_24_12 in ipairs(var_24_18.skills) do
		var_24_17[iter_24_11] = var_24_19[iter_24_12] or 1
	end

	var_24_6.skillLevel = var_24_17

	if var_24_0.servantInfo.id and var_24_0.servantInfo.id ~= 0 then
		local var_24_20 = HeroTools.GetHeroWeaponAddLevel(var_24_0)

		var_24_6.weaponEffectID = WeaponServantCfg[var_24_0.servantInfo.id].effect[1]
		var_24_6.weaponEffectLevel = var_24_0.servantInfo.stage + var_24_20
	end

	local var_24_21 = {}
	local var_24_22 = var_0_1:GetChipManagerID()

	if var_24_22 ~= 0 then
		table.insert(var_24_21, var_24_22)
	end

	if var_0_1:GetChipOfHeroDic()[var_24_6.ID] then
		if var_24_22 ~= 0 then
			for iter_24_13, iter_24_14 in ipairs(ChipData:GetCurChipManagerList(var_24_22)) do
				table.insert(var_24_21, iter_24_14)
			end
		end

		for iter_24_15, iter_24_16 in ipairs(var_0_1:GetChipOfHeroDic()[var_24_6.ID]) do
			table.insert(var_24_21, iter_24_16)
		end
	else
		local var_24_23 = var_0_1:GetChipList()

		if var_24_23 then
			for iter_24_17, iter_24_18 in ipairs(var_24_23) do
				table.insert(var_24_21, iter_24_18)
			end
		end
	end

	var_24_6.AIChip = var_24_21

	return var_24_6
end

function var_0_0.SetEquipBreakThroughMaterialHeroData(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0
	local var_25_1

	if arg_25_3 and arg_25_3 ~= 0 then
		var_25_0, var_25_1 = GetVirtualData(arg_25_3)
	else
		var_25_0, var_25_1 = GetPracticalData(arg_25_2)
	end

	local var_25_2 = GetHeroFinalAttr(var_25_0, var_25_0.servantInfo, var_25_1, arg_25_3)
	local var_25_3, var_25_4, var_25_5 = HeroTools.CalTransitionSkillAttribute(var_25_0, var_25_1)
	local var_25_6 = RoleDataForExchange.New()

	var_25_6.UID = arg_25_4
	var_25_6.playerLevel = arg_25_5
	var_25_6.ID = var_25_0.using_skin
	var_25_6.Level = LvTools.CheckHeroExp(1, var_25_0.exp, HeroConst.HERO_LV_MAX)

	local var_25_7 = {}
	local var_25_8 = {}
	local var_25_9 = EquipBreakThroughMaterialData:GetHeroState()[arg_25_1] and EquipBreakThroughMaterialData:GetHeroState()[arg_25_1].rate or 10000

	if var_25_9 then
		local var_25_10 = var_25_2[3]
		local var_25_11 = math.ceil(var_25_9 / 10000 * var_25_10)

		var_25_2[2002] = var_25_11
	end

	for iter_25_0, iter_25_1 in pairs(var_25_2) do
		if PublicAttrCfg[iter_25_0] or iter_25_0 == 2002 then
			table.insert(var_25_7, iter_25_0)
			table.insert(var_25_8, iter_25_1)
		end
	end

	local var_25_12, var_25_13 = BattleTools.FixBattleAttributeListAndWeaponModule(var_25_7, var_25_8, var_25_0.using_skin, var_25_0.weapon_module_level)

	var_25_6.attributeValue, var_25_6.attributeID = var_25_13, var_25_12

	local var_25_14 = {}
	local var_25_15 = {}

	for iter_25_2, iter_25_3 in pairs(var_25_4) do
		table.insert(var_25_14, iter_25_2)
		table.insert(var_25_15, iter_25_3)
	end

	var_25_6.equipSkillID = var_25_14
	var_25_6.equipSkillLv = var_25_15

	local var_25_16 = {}
	local var_25_17 = AstrolabeTools.GetTotalEffect(var_25_0.using_astrolabe)

	for iter_25_4 = 1, 9 do
		var_25_16[iter_25_4] = var_25_17[iter_25_4] or 0
	end

	var_25_6.astrolabe = var_25_16

	local var_25_18 = {}
	local var_25_19 = EquipTools.GetEffectS(var_25_1, var_25_0)

	for iter_25_5, iter_25_6 in pairs(var_25_19) do
		table.insert(var_25_18, iter_25_5)
	end

	var_25_6.equipment = var_25_18

	local var_25_20 = {}
	local var_25_21 = HeroCfg[var_25_0.id]
	local var_25_22 = {}

	for iter_25_7, iter_25_8 in ipairs(var_25_0.skill) do
		var_25_22[iter_25_8.skill_id] = iter_25_8.skill_level
	end

	for iter_25_9, iter_25_10 in pairs(var_25_5) do
		var_25_22[iter_25_9] = (var_25_22[iter_25_9] or 1) + iter_25_10
	end

	for iter_25_11, iter_25_12 in ipairs(var_25_21.skills) do
		var_25_20[iter_25_11] = var_25_22[iter_25_12] or 1
	end

	var_25_6.skillLevel = var_25_20

	if var_25_0.servantInfo.id and var_25_0.servantInfo.id ~= 0 then
		local var_25_23 = HeroTools.GetHeroWeaponAddLevel(var_25_0)

		var_25_6.weaponEffectID = WeaponServantCfg[var_25_0.servantInfo.id].effect[1]
		var_25_6.weaponEffectLevel = var_25_0.servantInfo.stage + var_25_23
	end

	var_25_6.AIChip = var_0_1:GetChipAndAIList(var_25_6.ID)

	return var_25_6
end

function var_0_0.SetPolyhedronHeroData(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	local var_26_0
	local var_26_1

	if arg_26_2 == nil then
		var_26_0, var_26_1 = GetVirtualData(arg_26_3)
	else
		var_26_0, var_26_1 = arg_26_2:GetVirtualData()
	end

	local var_26_2 = GetPolyhedronHeroPracticalAttr(arg_26_1, var_26_0, var_26_1, arg_26_3)
	local var_26_3, var_26_4, var_26_5 = HeroTools.CalTransitionSkillAttribute(var_26_0, var_26_1)
	local var_26_6 = RoleDataForExchange.New()

	var_26_6.UID = arg_26_4
	var_26_6.playerLevel = arg_26_5
	var_26_6.ID = PolyhedronData:GetHeroUsingSkinInfo(var_26_0.id).id
	var_26_6.Level = LvTools.CheckHeroExp(1, var_26_0.exp, HeroConst.HERO_LV_MAX)

	local var_26_7 = {}
	local var_26_8 = {}
	local var_26_9 = var_26_0.id
	local var_26_10 = arg_26_1:GetHeroPolyData(var_26_9)

	var_26_2[3] = var_26_10:GetHeroMaxHP()
	var_26_2[2002] = var_26_10:GetHeroHP()

	for iter_26_0, iter_26_1 in pairs(var_26_2) do
		if PublicAttrCfg[iter_26_0] or iter_26_0 == 2002 then
			table.insert(var_26_7, iter_26_0)
			table.insert(var_26_8, iter_26_1)
		end
	end

	var_26_6.attributeID = var_26_7
	var_26_6.attributeValue = var_26_8

	local var_26_11 = {}
	local var_26_12 = {}

	for iter_26_2, iter_26_3 in pairs(var_26_4) do
		table.insert(var_26_11, iter_26_2)
		table.insert(var_26_12, iter_26_3)
	end

	var_26_6.equipSkillID = var_26_11
	var_26_6.equipSkillLv = var_26_12

	local var_26_13 = {}
	local var_26_14 = AstrolabeTools.GetTotalEffect(var_26_0.using_astrolabe)

	for iter_26_4 = 1, 9 do
		var_26_13[iter_26_4] = var_26_14[iter_26_4] or 0
	end

	var_26_6.astrolabe = var_26_13

	local var_26_15 = {}
	local var_26_16 = EquipTools.GetEffectS(var_26_1, var_26_0)

	for iter_26_5, iter_26_6 in pairs(var_26_16) do
		table.insert(var_26_15, iter_26_5)
	end

	var_26_6.equipment = var_26_15

	local var_26_17 = {}
	local var_26_18 = HeroCfg[var_26_0.id]
	local var_26_19 = {}

	for iter_26_7, iter_26_8 in ipairs(var_26_0.skill) do
		var_26_19[iter_26_8.skill_id] = iter_26_8.skill_level
	end

	for iter_26_9, iter_26_10 in pairs(var_26_5) do
		var_26_19[iter_26_9] = (var_26_19[iter_26_9] or 1) + iter_26_10
	end

	for iter_26_11, iter_26_12 in ipairs(var_26_18.skills) do
		var_26_17[iter_26_11] = var_26_19[iter_26_12] or 1
	end

	var_26_6.skillLevel = var_26_17

	if var_26_0.servantInfo.id and var_26_0.servantInfo.id ~= 0 then
		local var_26_20 = HeroTools.GetHeroWeaponAddLevel(var_26_0)

		var_26_6.weaponEffectID = WeaponServantCfg[var_26_0.servantInfo.id].effect[1]
		var_26_6.weaponEffectLevel = var_26_0.servantInfo.stage + var_26_20
	end

	var_26_6.AIChip = {}

	return var_26_6
end

function var_0_0.SetNewWarChessHeroData(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0
	local var_27_1

	if arg_27_2 and arg_27_2 ~= 0 then
		var_27_0, var_27_1 = GetVirtualData(arg_27_2)
	else
		var_27_0, var_27_1 = GetPracticalData(arg_27_1)
	end

	local var_27_2 = GetHeroFinalAttr(var_27_0, var_27_0.servantInfo, var_27_1, arg_27_2)
	local var_27_3, var_27_4, var_27_5 = HeroTools.CalTransitionSkillAttribute(var_27_0, var_27_1)
	local var_27_6 = RoleDataForExchange.New()

	var_27_6.UID = arg_27_3
	var_27_6.playerLevel = arg_27_4
	var_27_6.ID = var_27_0.using_skin
	var_27_6.Level = LvTools.CheckHeroExp(1, var_27_0.exp, HeroConst.HERO_LV_MAX)

	local var_27_7 = var_27_0.id

	var_27_2[2002] = math.ceil(NewWarChessData:GetHeroHp(var_27_7) / NewChessConst.HERO_HP_RATE * var_27_2[3])

	local var_27_8 = {}
	local var_27_9 = {}

	for iter_27_0, iter_27_1 in pairs(var_27_2) do
		if PublicAttrCfg[iter_27_0] or iter_27_0 == 2002 then
			table.insert(var_27_8, iter_27_0)
			table.insert(var_27_9, iter_27_1)
		end
	end

	local var_27_10, var_27_11 = BattleTools.FixBattleAttributeListAndWeaponModule(var_27_8, var_27_9, var_27_0.using_skin, var_27_0.weapon_module_level)

	var_27_6.attributeValue, var_27_6.attributeID = var_27_11, var_27_10

	local var_27_12 = {}
	local var_27_13 = {}

	for iter_27_2, iter_27_3 in pairs(var_27_4) do
		table.insert(var_27_12, iter_27_2)
		table.insert(var_27_13, iter_27_3)
	end

	var_27_6.equipSkillID = var_27_12
	var_27_6.equipSkillLv = var_27_13

	local var_27_14 = {}
	local var_27_15 = AstrolabeTools.GetTotalEffect(var_27_0.using_astrolabe)

	for iter_27_4 = 1, 9 do
		var_27_14[iter_27_4] = var_27_15[iter_27_4] or 0
	end

	var_27_6.astrolabe = var_27_14

	local var_27_16 = {}
	local var_27_17 = EquipTools.GetEffectS(var_27_1, var_27_0)

	for iter_27_5, iter_27_6 in pairs(var_27_17) do
		table.insert(var_27_16, iter_27_5)
	end

	var_27_6.equipment = var_27_16

	local var_27_18 = {}
	local var_27_19 = HeroCfg[var_27_0.id]
	local var_27_20 = {}

	for iter_27_7, iter_27_8 in ipairs(var_27_0.skill) do
		var_27_20[iter_27_8.skill_id] = iter_27_8.skill_level
	end

	for iter_27_9, iter_27_10 in pairs(var_27_5) do
		var_27_20[iter_27_9] = (var_27_20[iter_27_9] or 1) + iter_27_10
	end

	for iter_27_11, iter_27_12 in ipairs(var_27_19.skills) do
		var_27_18[iter_27_11] = var_27_20[iter_27_12] or 1
	end

	var_27_6.skillLevel = var_27_18

	if var_27_0.servantInfo.id and var_27_0.servantInfo.id ~= 0 then
		local var_27_21 = HeroTools.GetHeroWeaponAddLevel(var_27_0)

		var_27_6.weaponEffectID = WeaponServantCfg[var_27_0.servantInfo.id].effect[1]
		var_27_6.weaponEffectLevel = var_27_0.servantInfo.stage + var_27_21
	end

	local var_27_22 = {}
	local var_27_23 = var_0_1:GetChipManagerID() or 0

	if var_27_23 ~= 0 then
		table.insert(var_27_22, var_27_23)
	end

	if var_0_1:GetChipOfHeroDic()[var_27_6.ID] then
		if var_27_23 ~= 0 then
			for iter_27_13, iter_27_14 in ipairs(ChipData:GetCurChipManagerList(var_27_23)) do
				table.insert(var_27_22, iter_27_14)
			end
		end

		for iter_27_15, iter_27_16 in ipairs(var_0_1:GetChipOfHeroDic()[var_27_6.ID]) do
			table.insert(var_27_22, iter_27_16)
		end
	else
		local var_27_24 = var_0_1:GetChipList()

		if var_27_24 then
			for iter_27_17, iter_27_18 in ipairs(var_27_24) do
				table.insert(var_27_22, iter_27_18)
			end
		end
	end

	var_27_6.AIChip = var_27_22

	return var_27_6
end

return var_0_0
