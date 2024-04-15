local var_0_0 = singletonClass("DormLinkGameData")
local var_0_1 = import("game.data.DormLinkGameTemplate")
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8

function var_0_0.CheckToEnterDormLinkScene(arg_1_0, arg_1_1)
	var_0_7 = arg_1_1

	if not ActivityLinkGameCfg[var_0_7] then
		var_0_7 = nil

		return
	end

	arg_1_0:InitGameInfo()
	DormMinigame.Launch("HZ07")
end

function var_0_0.GetCurLevelID(arg_2_0)
	if var_0_7 then
		return var_0_7
	end
end

local var_0_9
local var_0_10

function var_0_0.InitLevelInfo(arg_3_0, arg_3_1)
	var_0_2 = arg_3_1.activity_id
	var_0_9 = {}
	var_0_10 = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityLinkGameCfg.all) do
		local var_3_0 = {
			clear = false,
			activityID = iter_3_1,
			difficultyLevel = ActivityLinkGameCfg[iter_3_1].difficult
		}

		var_0_9[iter_3_1] = var_3_0
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.link_game) do
		if var_0_9[iter_3_3.id] then
			var_0_9[iter_3_3.id].maxPoint = iter_3_3.point
		end
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.receive_reward) do
		arg_3_0:SetRewardInfo(iter_3_5, true)
	end

	arg_3_0:CheckUnCompleteLevel()
	arg_3_0:CheckUnReciveLevelReward()
end

function var_0_0.GetAwardInfo(arg_4_0, arg_4_1)
	if var_0_10 then
		return var_0_10[arg_4_1]
	end
end

function var_0_0.SetRewardInfo(arg_5_0, arg_5_1, arg_5_2)
	if not var_0_10 then
		var_0_10 = {}
	end

	var_0_10[arg_5_1] = arg_5_2
end

function var_0_0.GetMainActivityID(arg_6_0)
	return var_0_2
end

function var_0_0.GetLevelInfoList(arg_7_0)
	if var_0_9 then
		return var_0_9
	end
end

function var_0_0.CheckLevelIsClear(arg_8_0, arg_8_1)
	local var_8_0 = {
		arg_8_1 * 2 - 1,
		arg_8_1 * 2
	}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if var_0_9[iter_8_1] and var_0_9[iter_8_1].maxPoint then
			return true
		end
	end

	return false
end

function var_0_0.CheckLevelRewardState(arg_9_0, arg_9_1)
	if var_0_10 and var_0_10[arg_9_1] then
		return DormLinkGameConst.RewardItemState.received
	end

	local var_9_0 = ActivityLinkGameRewardCfg[arg_9_1].condition
	local var_9_1 = ConditionCfg[var_9_0]

	if var_9_1.type == DormLinkGameConst.AwardCondition.Point then
		local var_9_2 = var_9_1.params[1]
		local var_9_3 = var_9_1.params[2]
		local var_9_4 = ActivityLinkGameRewardCfg[arg_9_1].activity_id
		local var_9_5
		local var_9_6 = 0

		if var_9_2 == 0 then
			local var_9_7 = 0

			for iter_9_0, iter_9_1 in ipairs(ActivityLinkGameCfg.all) do
				if ActivityLinkGameCfg[iter_9_1].activity_id == var_9_4 and var_0_9[iter_9_1] then
					var_9_7 = math.max(var_9_7, var_0_9[iter_9_1].maxPoint or 0)
				end
			end

			var_9_6 = var_9_7
		else
			local var_9_8 = DormLinkGameTools:GetLevelIDByDiffAndActivityID(var_9_4, var_9_2)

			if var_0_9[var_9_8] then
				var_9_6 = var_0_9[var_9_8].maxPoint or 0
			else
				var_9_6 = 0
			end
		end

		if var_9_3 <= var_9_6 then
			return DormLinkGameConst.RewardItemState.complete
		else
			return DormLinkGameConst.RewardItemState.unComplete
		end
	end
end

function var_0_0.GetAllLevelTopPoint(arg_10_0)
	local var_10_0 = 0

	if var_0_9 then
		for iter_10_0, iter_10_1 in pairs(var_0_9) do
			if iter_10_1.maxPoint then
				var_10_0 = math.max(var_10_0, iter_10_1.maxPoint)
			end
		end
	end

	return var_10_0
end

function var_0_0.CheckActivityComplete(arg_11_0, arg_11_1)
	local var_11_0 = ActivityLinkGameCfg.get_id_list_by_activity_id[arg_11_1]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if var_0_9[iter_11_1].maxPoint then
			return true
		end
	end

	return false
end

function var_0_0.GetLevelInfoByIndexAndDiff(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == 2 then
		return arg_12_1 * 2
	else
		return arg_12_1 * 2 - 1
	end
end

function var_0_0.GetIndexAndDiffByLevelInfo(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1 = ActivityLinkGameCfg[arg_13_1].difficult

	if arg_13_1 % 2 == 0 then
		var_13_0 = arg_13_1 / 2
	else
		var_13_0 = (arg_13_1 + 1) / 2
	end

	return var_13_0, var_13_1
end

function var_0_0.GetLevelScore(arg_14_0, arg_14_1)
	if var_0_9[arg_14_1] then
		return var_0_9[arg_14_1].maxPoint
	end
end

function var_0_0.GetCurCnaUseTokenNum(arg_15_0)
	local var_15_0 = DormLinkGameTools:GetCurrencyID(var_0_2)
	local var_15_1 = ItemTools.getItemNum(var_15_0)

	if var_0_4 then
		return var_15_1 - var_0_4.costTokenNum
	else
		return var_15_1
	end
end

local var_0_11

function var_0_0.InitGameInfo(arg_16_0)
	arg_16_0:InitSceneData()
	arg_16_0:InitCacheData()

	var_0_11 = false
end

function var_0_0.InitSceneData(arg_17_0)
	if var_0_7 then
		var_0_3 = {}
		var_0_3 = {
			levelID = var_0_7,
			difficultyLevel = ActivityLinkGameCfg[var_0_7].difficult,
			canUseItem = ActivityLinkGameCfg[var_0_7].property_limit,
			limitTime = ActivityLinkGameCfg[var_0_7].time_limit
		}
	end
end

function var_0_0.GetSceneData(arg_18_0)
	return var_0_3
end

function var_0_0.InitCacheData(arg_19_0)
	if var_0_7 then
		var_0_4 = {}
		var_0_4 = {
			basePoint = 0,
			drainPoint = 0,
			drainMaterialNum = 0,
			batterNum = 0,
			costTokenNum = 0,
			eliminateNum = 0,
			highestBatterNum = 0,
			gameTime = 0,
			customerAddition = 0,
			batterAddition = 0,
			batterMaterial = {},
			generateInterval = ActivityLinkGameCfg[var_0_7].time_interval / 100,
			extendPoint = ActivityLinkGameCfg[var_0_7].extra_score,
			useItemList = {}
		}
		var_0_5 = false
		var_0_8 = true
	end
end

function var_0_0.DisposeGameCacheInfo(arg_20_0)
	var_0_4 = nil
end

function var_0_0.GetGameCacheInfo(arg_21_0)
	if var_0_4 then
		return var_0_4
	end
end

function var_0_0.GetGameCurLevel(arg_22_0)
	if var_0_4 then
		return var_0_4.levelID
	end
end

function var_0_0.InitCustomerInfo(arg_23_0)
	if var_0_7 then
		var_0_6 = {}

		local var_23_0 = DormUtils.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer)

		for iter_23_0, iter_23_1 in Dorm.storage:ForeachData(var_23_0, pairs) do
			local var_23_1 = DormUtils.GetEntityData(iter_23_1).cfgID
			local var_23_2 = {
				customerID = var_23_1,
				customerEID = iter_23_1,
				posIndex = iter_23_0
			}

			var_0_6[var_23_1] = var_0_1.New(var_23_2)
		end
	end
end

function var_0_0.GetCustomerList(arg_24_0)
	return var_0_6
end

function var_0_0.GetCustomerInfo(arg_25_0, arg_25_1)
	if var_0_6[arg_25_1] then
		return var_0_6[arg_25_1]
	else
		print("未找到食客信息")
	end
end

local var_0_12

function var_0_0.RunGameTimer(arg_26_0)
	if not var_0_12 then
		var_0_12 = {}
	end

	if not var_0_12.gameTimer then
		local var_26_0 = var_0_3.limitTime

		var_0_12.gameTimer = Timer.New(function()
			var_0_4.gameTime = var_0_4.gameTime + 1
			var_26_0 = var_26_0 - 1

			if var_26_0 <= 0 then
				arg_26_0:StopGame(DormLinkGameConst.StopGameType.success)
			else
				manager.notify:Invoke(DORM_LINK_REFRESH_GAME_TIME, var_26_0)
			end

			local var_27_0 = {
				num = var_26_0
			}

			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.LastTime, var_27_0)
		end, 1, -1)

		var_0_12.gameTimer:Start()
	end

	if not var_0_12.customerTimer then
		var_0_12.customerTimer = Timer.New(function()
			for iter_28_0, iter_28_1 in pairs(var_0_6) do
				local var_28_0 = ActivityLinkGameCustomerCfg[iter_28_1.ID].satiety_descend_rate

				iter_28_1:ReviseSatiety(-var_28_0)
			end
		end, 1, -1)

		var_0_12.customerTimer:Start()
	end

	if not var_0_12.startGenerateTimer then
		local var_26_1 = GameSetting.linkgame_count_down.value[1]

		var_0_12.startGenerateTimer = Timer.New(function()
			if var_0_8 then
				var_26_1 = var_26_1 - DormLinkGameConst.GenerateTick

				if var_26_1 <= 0 then
					arg_26_0:RefreshMaterialGenerateTimer()
				else
					manager.notify:Invoke(DORM_LINK_REFRESH_MATERIAL_TIME, var_26_1 + var_0_4.generateInterval)
				end
			end
		end, DormLinkGameConst.GenerateTick, -1)

		var_0_12.startGenerateTimer:Start()
	end
end

function var_0_0.RefreshMaterialGenerateTimer(arg_30_0)
	local var_30_0 = var_0_4.generateInterval

	if not var_0_12.generateTimer then
		var_0_12.generateTimer = Timer.New(function()
			if var_0_8 then
				var_30_0 = var_30_0 - DormLinkGameConst.GenerateTick

				if var_30_0 <= 0 then
					arg_30_0:GenerateMaterialList()

					var_30_0 = var_0_4.generateInterval
				end

				manager.notify:Invoke(DORM_LINK_REFRESH_MATERIAL_TIME, var_30_0)
			end
		end, DormLinkGameConst.GenerateTick, -1)

		var_0_12.generateTimer:Start()
	end
end

function var_0_0.PauseMaterialGenerate(arg_32_0, arg_32_1)
	if var_0_12.pauseTimer then
		var_0_12.pauseTimer:Stop()

		var_0_12.pauseTimer = nil
	end

	if var_0_12.generateTimer then
		var_0_8 = false
		var_0_12.pauseTimer = Timer.New(function()
			var_0_8 = true
		end, arg_32_1, 1)

		var_0_12.pauseTimer:Start()
	elseif var_0_12.startGenerateTimer then
		var_0_8 = false
		var_0_12.pauseTimer = Timer.New(function()
			var_0_8 = true
		end, arg_32_1, 1)

		var_0_12.pauseTimer:Start()
	end
end

function var_0_0.ReSetBatterTimer(arg_35_0)
	if var_0_12.batterTimer and var_0_5 then
		var_0_12.batterTimer:Reset()
	else
		local var_35_0 = GameSetting.linkgame_hit_time.value[1]

		var_0_12.batterTimer = Timer.New(function()
			var_0_5 = false

			arg_35_0:ClearBatterNum()
		end, var_35_0, 1)
	end

	var_0_12.batterTimer:Start()
end

function var_0_0.StopTimer(arg_37_0)
	if var_0_12 then
		for iter_37_0, iter_37_1 in pairs(var_0_12) do
			iter_37_1:Stop()
		end
	end
end

function var_0_0.DisposeTimer(arg_38_0)
	if var_0_12 then
		for iter_38_0, iter_38_1 in pairs(var_0_12) do
			iter_38_1:Stop()

			iter_38_1 = nil
			var_0_12[iter_38_0] = nil
		end
	end
end

local var_0_13

function var_0_0.PlayerStartGame(arg_39_0)
	var_0_13 = true

	arg_39_0:RunGameTimer()
	manager.audio:PlayBGM("bgm_activity_2_1_minigame_connect", "bgm_activity_2_1_minigame_connect", "bgm_activity_2_1_minigame_connect.awb")
	manager.notify:Invoke(DORM_LINK_START_PLAY)

	if var_0_3 then
		local var_39_0 = ActivityLinkGameCfg[var_0_3.levelID].activity_id

		if var_0_3.difficultyLevel and var_39_0 then
			local var_39_1 = 1

			if not var_0_11 then
				var_39_1 = 2
			end

			SDKTools.SendMessageToSDK("activity_linkgame_end", {
				difficulty_id = var_0_3.difficultyLevel,
				activity_id = var_39_0,
				end_type = var_39_1
			})
		end
	end
end

function var_0_0.StopGame(arg_40_0, arg_40_1)
	manager.audio:Stop("music")
	manager.audio:Stop("effect")

	if var_0_13 then
		manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_end", "")

		var_0_13 = nil
	else
		manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_end02", "")
	end

	arg_40_0:StopTimer()

	if arg_40_1 == DormLinkGameConst.StopGameType.success then
		DormLinkGameAction:ClearanceLevel(var_0_3.levelID, var_0_4)
	elseif arg_40_1 == DormLinkGameConst.StopGameType.fail then
		arg_40_0:FailedClear()
	end
end

function var_0_0.SuccessClear(arg_41_0)
	local var_41_0, var_41_1 = arg_41_0:GetLastPoint()

	var_0_9[var_0_7].maxPoint = var_0_9[var_0_7].maxPoint or 0
	var_0_9[var_0_7].maxPoint = math.max(var_0_9[var_0_7].maxPoint, var_41_0)
	var_0_4.highestBatterNum = math.max(var_0_4.highestBatterNum, var_0_4.batterNum)

	local var_41_2 = {
		totalPoint = var_41_0,
		extendPoint = var_41_1,
		time = var_0_4.gameTime
	}
	local var_41_3 = ActivityLinkGameCfg[var_0_3.levelID].activity_id

	if var_0_3.difficultyLevel and var_41_3 then
		SDKTools.SendMessageToSDK("activity_linkgame_finish", {
			hit_num = var_0_4.highestBatterNum,
			cell_num = var_0_4.eliminateNum,
			activity_id = var_41_3,
			difficulty_id = var_0_3.difficultyLevel
		})
	end

	arg_41_0:DisposeRunGameInfo()
	arg_41_0:SaveDefaultLevelAndDiff(var_0_7)
	arg_41_0:CheckUnReciveLevelReward()
	manager.notify:Invoke(DORM_LINK_END_GAME, DormLinkGameConst.StopGameType.success, var_41_2)
end

function var_0_0.FailedClear(arg_42_0)
	arg_42_0:DisposeRunGameInfo()
	manager.notify:Invoke(DORM_LINK_END_GAME, DormLinkGameConst.StopGameType.fail)
end

function var_0_0.DisposeRunGameInfo(arg_43_0)
	arg_43_0:DisposeGameCacheInfo()
	arg_43_0:DisposeTimer()

	var_0_6 = nil
end

function var_0_0.ResetRunGameInfo(arg_44_0)
	var_0_11 = true

	arg_44_0:InitCacheData()
	arg_44_0:InitCustomerInfo()
end

function var_0_0.DisposeGameInfo(arg_45_0)
	var_0_3 = nil
	var_0_5 = nil
end

function var_0_0.EliminateMaterial(arg_46_0, arg_46_1)
	arg_46_0:ReSetBatterTimer()

	var_0_5 = true

	if not var_0_4.batterMaterial[arg_46_1] then
		var_0_4.batterMaterial[arg_46_1] = 0
	end

	var_0_4.eliminateNum = var_0_4.eliminateNum + 1
	var_0_4.batterMaterial[arg_46_1] = var_0_4.batterMaterial[arg_46_1] + 1

	local var_46_0 = {}

	arg_46_0:UpdataCustomerNeed(var_46_0)

	if var_0_6 then
		for iter_46_0, iter_46_1 in pairs(var_0_6) do
			local var_46_1 = var_46_0[iter_46_0]

			manager.notify:Invoke(DORM_LINK_REFRESH_CUSTOMER_BUBBLE, iter_46_0, var_46_1)
		end
	end

	arg_46_0:AddBatterNum()
	arg_46_0:RefreshBasePoint(arg_46_1)
end

function var_0_0.RefreshBasePoint(arg_47_0, arg_47_1)
	local var_47_0 = 0

	for iter_47_0, iter_47_1 in pairs(var_0_6) do
		var_47_0 = var_47_0 + iter_47_1.satietyAddition
	end

	var_0_4.customerAddition = var_47_0

	if ActivityLinkGameCellCfg[arg_47_1] then
		var_0_4.basePoint = var_0_4.basePoint + ActivityLinkGameCellCfg[arg_47_1].complete_score * (100 + var_0_4.batterAddition + var_47_0) / 100
	end
end

function var_0_0.AddBatterNum(arg_48_0)
	var_0_4.batterNum = var_0_4.batterNum + 1

	arg_48_0:RefreshExtendAddition()
	arg_48_0:RefreshGenerateInterval()

	local var_48_0 = {
		oldNum = var_0_4.batterNum - 1,
		newNum = var_0_4.batterNum
	}

	DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.SuccssBatterNum, var_48_0)
	manager.notify:Invoke(DORM_LINK_REFRESH_BATTER_NUM)
end

function var_0_0.ClearBatterNum(arg_49_0)
	var_0_4.highestBatterNum = math.max(var_0_4.highestBatterNum, var_0_4.batterNum)

	local var_49_0 = {
		num = var_0_4.batterNum
	}

	DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.FaileBatterNum, var_49_0)

	var_0_4.batterNum = 0

	arg_49_0:RefreshGenerateInterval()
	arg_49_0:RefreshExtendAddition()
	manager.notify:Invoke(DORM_LINK_REFRESH_BATTER_NUM)
end

function var_0_0.GetBatterNum(arg_50_0)
	return var_0_4.batterNum
end

function var_0_0.GetExtendAddition(arg_51_0)
	return var_0_4.batterAddition + var_0_4.customerAddition
end

function var_0_0.RefreshExtendAddition(arg_52_0)
	local var_52_0 = ActivityLinkGameCfg[var_0_7].hit_score_up
	local var_52_1 = arg_52_0:GetExtendAddition()
	local var_52_2 = var_0_4.batterNum

	var_0_4.batterAddition = 0

	if var_52_0 then
		for iter_52_0, iter_52_1 in ipairs(var_52_0) do
			if var_52_2 >= iter_52_1[1] then
				var_0_4.batterAddition = 0 + iter_52_1[2]

				if var_0_4.batterAddition <= 0 then
					print("连击加成错误")
				end
			end
		end
	end

	if var_52_1 ~= arg_52_0:GetExtendAddition() then
		manager.notify:Invoke(DORM_LINK_REFRESH_EXTEND_ADDITION)
	end
end

function var_0_0.RefreshCustomerExtendAddition(arg_53_0)
	local var_53_0 = arg_53_0:GetExtendAddition()

	var_0_4.customerAddition = 0

	for iter_53_0, iter_53_1 in pairs(var_0_6) do
		var_0_4.customerAddition = var_0_4.customerAddition + iter_53_1.satietyAddition
	end

	if var_53_0 ~= arg_53_0:GetExtendAddition() then
		manager.notify:Invoke(DORM_LINK_REFRESH_EXTEND_ADDITION)
	end
end

function var_0_0.RefreshGenerateInterval(arg_54_0)
	if not var_0_4 then
		print("操作数据不存在")
	end

	local var_54_0 = var_0_4.batterNum
	local var_54_1 = ActivityLinkGameCfg[var_0_7].hit_interval_cut

	var_0_4.generateInterval = ActivityLinkGameCfg[var_0_7].time_interval / 100

	if var_54_1 then
		for iter_54_0, iter_54_1 in ipairs(var_54_1) do
			if var_54_0 >= iter_54_1[1] then
				var_0_4.generateInterval = (ActivityLinkGameCfg[var_0_7].time_interval - iter_54_1[2]) / 100

				if var_0_4.generateInterval <= 0 then
					print("生成间隔时间错误")
				end
			end
		end
	end
end

function var_0_0.GetDisposeMaterialNum(arg_55_0, arg_55_1)
	return var_0_4.batterMaterial[arg_55_1] or 0
end

function var_0_0.UpdataCustomerNeed(arg_56_0, arg_56_1)
	if var_0_6 then
		for iter_56_0, iter_56_1 in pairs(var_0_6) do
			local var_56_0 = iter_56_1.curPreference
			local var_56_1 = true

			for iter_56_2, iter_56_3 in ipairs(ActivityLinkGameComposeCfg[var_56_0].compose_list) do
				local var_56_2 = iter_56_3[1]

				if iter_56_3[2] > arg_56_0:GetDisposeMaterialNum(var_56_2) then
					var_56_1 = false

					break
				end
			end

			if var_56_1 then
				for iter_56_4, iter_56_5 in ipairs(ActivityLinkGameComposeCfg[var_56_0].compose_list) do
					local var_56_3 = iter_56_5[1]
					local var_56_4 = iter_56_5[2]

					var_0_4.batterMaterial[var_56_3] = var_0_4.batterMaterial[var_56_3] - var_56_4
				end

				iter_56_1:FoodComplate()
			end

			if arg_56_1 then
				arg_56_1[iter_56_0] = var_56_1
			end
		end
	end
end

function var_0_0.GetCurMaterialState(arg_57_0)
	if var_0_4 then
		return var_0_4.materialstate
	end
end

function var_0_0.GenerateMaterialList(arg_58_0)
	manager.notify:Invoke(LIANLIANKAN_PREVIEW_APPEAR)
end

function var_0_0.ClearConveyorMaterial(arg_59_0, arg_59_1)
	manager.notify:Invoke(LIANLIANKAN_PREVIEW_REMOVE_ALL, arg_59_1, true)
end

function var_0_0.DrainMaterial(arg_60_0, arg_60_1)
	local var_60_0 = 0

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		var_0_4.drainMaterialNum = var_0_4.drainMaterialNum + 1
		var_60_0 = var_60_0 + ActivityLinkGameCellCfg[iter_60_1].waste_score
	end

	var_0_4.drainPoint = var_0_4.drainPoint + var_60_0

	if var_60_0 > 0 then
		manager.notify:Invoke(DORM_LINK_REFRESH_DRAIN_MATERIAL, var_60_0)
	end
end

function var_0_0.GetLastPoint(arg_61_0)
	local var_61_0 = var_0_4.basePoint
	local var_61_1 = var_0_4.extendPoint - var_0_4.drainPoint

	if var_61_1 < 0 then
		var_61_1 = 0
	end

	local var_61_2 = var_0_4.gameTime
	local var_61_3 = ActivityLinkGameCfg[var_0_7].time_limit - var_61_2

	if var_61_3 < 0 then
		var_61_3 = 0
	end

	local var_61_4 = var_61_3 * GameSetting.linkgame_time_score.value[1]

	return var_61_0 + var_61_1 + var_61_4, var_61_1 + var_61_4
end

function var_0_0.GetSaveLevelID(arg_62_0)
	local var_62_0 = USER_ID

	return getData(string.format("%s_%d", "DormLinkLevel", var_62_0), "levelID") or ActivityLinkGameCfg[ActivityLinkGameCfg.all[1]].id
end

function var_0_0.SaveDefaultLevelAndDiff(arg_63_0, arg_63_1)
	local var_63_0 = USER_ID

	saveData(string.format("%s_%d", "DormLinkLevel", var_63_0), "levelID", arg_63_1)
end

function var_0_0.CheckUnCompleteLevel(arg_64_0)
	if var_0_9 then
		for iter_64_0, iter_64_1 in pairs(ActivityLinkGameCfg.get_id_list_by_activity_id) do
			if DormLinkGameTools:ChecklevelUnLock(iter_64_1[1]) then
				local var_64_0 = false

				for iter_64_2, iter_64_3 in ipairs(iter_64_1) do
					if var_0_9[iter_64_3] and var_0_9[iter_64_3].maxPoint then
						var_64_0 = true

						break
					end
				end

				if not var_64_0 then
					manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_UNCOMPLETE_LEVEL, 1)

					return
				end
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_UNCOMPLETE_LEVEL, 0)
end

function var_0_0.CheckUnReciveLevelReward(arg_65_0)
	local var_65_0 = ActivityLinkGameRewardCfg.all

	for iter_65_0, iter_65_1 in ipairs(var_65_0) do
		if (not var_0_10 or var_0_10 and not var_0_10[iter_65_1]) and DormLinkGameData:CheckLevelRewardState(iter_65_1) == DormLinkGameConst.RewardItemState.complete then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD, 0)
end

function var_0_0.CheckUnReciveTaskReward(arg_66_0)
	local var_66_0 = DormLinkGameTools:GetTaskActivityID(var_0_2)

	arg_66_0.list_ = {}

	local var_66_1 = TaskTools:GetActivityTaskList(var_66_0) or {}

	for iter_66_0, iter_66_1 in pairs(var_66_1) do
		local var_66_2 = iter_66_1.id
		local var_66_3 = AssignmentCfg[var_66_2]

		if var_66_3.activity_id == var_66_0 and iter_66_1.progress >= var_66_3.need and iter_66_1.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_TASK_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_TASK_REWARD, 0)
end

return var_0_0
