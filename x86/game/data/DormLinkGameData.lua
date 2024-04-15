slot0 = singletonClass("DormLinkGameData")
slot1 = import("game.data.DormLinkGameTemplate")
slot2, slot3, slot4, slot5, slot6, slot7, slot8 = nil

function slot0.CheckToEnterDormLinkScene(slot0, slot1)
	uv0 = slot1

	if not ActivityLinkGameCfg[uv0] then
		uv0 = nil

		return
	end

	slot0:InitGameInfo()
	DormMinigame.Launch("HZ07")
end

function slot0.GetCurLevelID(slot0)
	if uv0 then
		return uv0
	end
end

slot9, slot10 = nil

function slot0.InitLevelInfo(slot0, slot1)
	uv0 = slot1.activity_id
	uv1 = {}
	uv2 = {}

	for slot5, slot6 in ipairs(ActivityLinkGameCfg.all) do
		uv1[slot6] = {
			clear = false,
			activityID = slot6,
			difficultyLevel = ActivityLinkGameCfg[slot6].difficult
		}
	end

	for slot5, slot6 in ipairs(slot1.link_game) do
		if uv1[slot6.id] then
			uv1[slot6.id].maxPoint = slot6.point
		end
	end

	for slot5, slot6 in ipairs(slot1.receive_reward) do
		slot0:SetRewardInfo(slot6, true)
	end

	slot0:CheckUnCompleteLevel()
	slot0:CheckUnReciveLevelReward()
end

function slot0.GetAwardInfo(slot0, slot1)
	if uv0 then
		return uv0[slot1]
	end
end

function slot0.SetRewardInfo(slot0, slot1, slot2)
	if not uv0 then
		uv0 = {}
	end

	uv0[slot1] = slot2
end

function slot0.GetMainActivityID(slot0)
	return uv0
end

function slot0.GetLevelInfoList(slot0)
	if uv0 then
		return uv0
	end
end

function slot0.CheckLevelIsClear(slot0, slot1)
	for slot6, slot7 in ipairs({
		slot1 * 2 - 1,
		slot1 * 2
	}) do
		if uv0[slot7] and uv0[slot7].maxPoint then
			return true
		end
	end

	return false
end

function slot0.CheckLevelRewardState(slot0, slot1)
	if uv0 and uv0[slot1] then
		return DormLinkGameConst.RewardItemState.received
	end

	if ConditionCfg[ActivityLinkGameRewardCfg[slot1].condition].type == DormLinkGameConst.AwardCondition.Point then
		slot5 = slot3.params[2]
		slot6 = ActivityLinkGameRewardCfg[slot1].activity_id
		slot7 = nil
		slot8 = 0

		if slot3.params[1] == 0 then
			for slot13, slot14 in ipairs(ActivityLinkGameCfg.all) do
				if ActivityLinkGameCfg[slot14].activity_id == slot6 and uv1[slot14] then
					slot9 = math.max(0, uv1[slot14].maxPoint or 0)
				end
			end

			slot8 = slot9
		else
			slot8 = uv1[DormLinkGameTools:GetLevelIDByDiffAndActivityID(slot6, slot4)] and (uv1[slot7].maxPoint or 0) or 0
		end

		if slot5 <= slot8 then
			return DormLinkGameConst.RewardItemState.complete
		else
			return DormLinkGameConst.RewardItemState.unComplete
		end
	end
end

function slot0.GetAllLevelTopPoint(slot0)
	slot1 = 0

	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			if slot6.maxPoint then
				slot1 = math.max(slot1, slot6.maxPoint)
			end
		end
	end

	return slot1
end

function slot0.CheckActivityComplete(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityLinkGameCfg.get_id_list_by_activity_id[slot1]) do
		if uv0[slot7].maxPoint then
			return true
		end
	end

	return false
end

function slot0.GetLevelInfoByIndexAndDiff(slot0, slot1, slot2)
	if slot2 == 2 then
		return slot1 * 2
	else
		return slot1 * 2 - 1
	end
end

function slot0.GetIndexAndDiffByLevelInfo(slot0, slot1)
	slot2 = nil

	return slot1 % 2 == 0 and slot1 / 2 or (slot1 + 1) / 2, ActivityLinkGameCfg[slot1].difficult
end

function slot0.GetLevelScore(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].maxPoint
	end
end

function slot0.GetCurCnaUseTokenNum(slot0)
	if uv1 then
		return ItemTools.getItemNum(DormLinkGameTools:GetCurrencyID(uv0)) - uv1.costTokenNum
	else
		return slot2
	end
end

slot11 = nil

function slot0.InitGameInfo(slot0)
	slot0:InitSceneData()
	slot0:InitCacheData()

	uv0 = false
end

function slot0.InitSceneData(slot0)
	if uv0 then
		uv1 = {}
		uv1 = {
			levelID = uv0,
			difficultyLevel = ActivityLinkGameCfg[uv0].difficult,
			canUseItem = ActivityLinkGameCfg[uv0].property_limit,
			limitTime = ActivityLinkGameCfg[uv0].time_limit
		}
	end
end

function slot0.GetSceneData(slot0)
	return uv0
end

function slot0.InitCacheData(slot0)
	if uv0 then
		uv1 = {}
		uv1 = {
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
			generateInterval = ActivityLinkGameCfg[uv0].time_interval / 100,
			extendPoint = ActivityLinkGameCfg[uv0].extra_score,
			useItemList = {}
		}
		uv2 = false
		uv3 = true
	end
end

function slot0.DisposeGameCacheInfo(slot0)
	uv0 = nil
end

function slot0.GetGameCacheInfo(slot0)
	if uv0 then
		return uv0
	end
end

function slot0.GetGameCurLevel(slot0)
	if uv0 then
		return uv0.levelID
	end
end

function slot0.InitCustomerInfo(slot0)
	if uv0 then
		uv1 = {}
		slot5 = pairs

		for slot5, slot6 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer), slot5) do
			slot8 = DormUtils.GetEntityData(slot6).cfgID
			uv1[slot8] = uv2.New({
				customerID = slot8,
				customerEID = slot6,
				posIndex = slot5
			})
		end
	end
end

function slot0.GetCustomerList(slot0)
	return uv0
end

function slot0.GetCustomerInfo(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	else
		print("未找到食客信息")
	end
end

slot12 = nil

function slot0.RunGameTimer(slot0)
	if not uv0 then
		uv0 = {}
	end

	if not uv0.gameTimer then
		slot1 = uv1.limitTime
		uv0.gameTimer = Timer.New(function ()
			uv0.gameTime = uv0.gameTime + 1
			uv1 = uv1 - 1

			if uv1 <= 0 then
				uv2:StopGame(DormLinkGameConst.StopGameType.success)
			else
				manager.notify:Invoke(DORM_LINK_REFRESH_GAME_TIME, uv1)
			end

			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.LastTime, {
				num = uv1
			})
		end, 1, -1)

		uv0.gameTimer:Start()
	end

	if not uv0.customerTimer then
		uv0.customerTimer = Timer.New(function ()
			for slot3, slot4 in pairs(uv0) do
				slot4:ReviseSatiety(-ActivityLinkGameCustomerCfg[slot4.ID].satiety_descend_rate)
			end
		end, 1, -1)

		uv0.customerTimer:Start()
	end

	if not uv0.startGenerateTimer then
		slot1 = GameSetting.linkgame_count_down.value[1]
		uv0.startGenerateTimer = Timer.New(function ()
			if uv0 then
				uv1 = uv1 - DormLinkGameConst.GenerateTick

				if uv1 <= 0 then
					uv2:RefreshMaterialGenerateTimer()
				else
					manager.notify:Invoke(DORM_LINK_REFRESH_MATERIAL_TIME, uv1 + uv3.generateInterval)
				end
			end
		end, DormLinkGameConst.GenerateTick, -1)

		uv0.startGenerateTimer:Start()
	end
end

function slot0.RefreshMaterialGenerateTimer(slot0)
	slot1 = uv0.generateInterval

	if not uv1.generateTimer then
		uv1.generateTimer = Timer.New(function ()
			if uv0 then
				uv1 = uv1 - DormLinkGameConst.GenerateTick

				if uv1 <= 0 then
					uv2:GenerateMaterialList()

					uv1 = uv3.generateInterval
				end

				manager.notify:Invoke(DORM_LINK_REFRESH_MATERIAL_TIME, uv1)
			end
		end, DormLinkGameConst.GenerateTick, -1)

		uv1.generateTimer:Start()
	end
end

function slot0.PauseMaterialGenerate(slot0, slot1)
	if uv0.pauseTimer then
		uv0.pauseTimer:Stop()

		uv0.pauseTimer = nil
	end

	if uv0.generateTimer then
		uv1 = false
		uv0.pauseTimer = Timer.New(function ()
			uv0 = true
		end, slot1, 1)

		uv0.pauseTimer:Start()
	elseif uv0.startGenerateTimer then
		uv1 = false
		uv0.pauseTimer = Timer.New(function ()
			uv0 = true
		end, slot1, 1)

		uv0.pauseTimer:Start()
	end
end

function slot0.ReSetBatterTimer(slot0)
	if uv0.batterTimer and uv1 then
		uv0.batterTimer:Reset()
	else
		uv0.batterTimer = Timer.New(function ()
			uv0 = false

			uv1:ClearBatterNum()
		end, GameSetting.linkgame_hit_time.value[1], 1)
	end

	uv0.batterTimer:Start()
end

function slot0.StopTimer(slot0)
	if uv0 then
		for slot4, slot5 in pairs(uv0) do
			slot5:Stop()
		end
	end
end

function slot0.DisposeTimer(slot0)
	if uv0 then
		for slot4, slot5 in pairs(uv0) do
			slot5:Stop()

			slot5 = nil
			uv0[slot4] = nil
		end
	end
end

slot13 = nil

function slot0.PlayerStartGame(slot0)
	uv0 = true

	slot0:RunGameTimer()
	manager.audio:PlayBGM("bgm_activity_2_1_minigame_connect", "bgm_activity_2_1_minigame_connect", "bgm_activity_2_1_minigame_connect.awb")
	manager.notify:Invoke(DORM_LINK_START_PLAY)

	if uv1 then
		slot1 = ActivityLinkGameCfg[uv1.levelID].activity_id

		if uv1.difficultyLevel and slot1 then
			slot2 = 1

			if not uv2 then
				slot2 = 2
			end

			SDKTools.SendMessageToSDK("activity_linkgame_end", {
				difficulty_id = uv1.difficultyLevel,
				activity_id = slot1,
				end_type = slot2
			})
		end
	end
end

function slot0.StopGame(slot0, slot1)
	manager.audio:Stop("music")
	manager.audio:Stop("effect")

	if uv0 then
		manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_end", "")

		uv0 = nil
	else
		manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_end02", "")
	end

	slot0:StopTimer()

	if slot1 == DormLinkGameConst.StopGameType.success then
		DormLinkGameAction:ClearanceLevel(uv1.levelID, uv2)
	elseif slot1 == DormLinkGameConst.StopGameType.fail then
		slot0:FailedClear()
	end
end

function slot0.SuccessClear(slot0)
	slot1, slot2 = slot0:GetLastPoint()
	uv0[uv1].maxPoint = uv0[uv1].maxPoint or 0
	uv0[uv1].maxPoint = math.max(uv0[uv1].maxPoint, slot1)
	uv2.highestBatterNum = math.max(uv2.highestBatterNum, uv2.batterNum)
	slot3 = {
		totalPoint = slot1,
		extendPoint = slot2,
		time = uv2.gameTime
	}
	slot4 = ActivityLinkGameCfg[uv3.levelID].activity_id

	if uv3.difficultyLevel and slot4 then
		SDKTools.SendMessageToSDK("activity_linkgame_finish", {
			hit_num = uv2.highestBatterNum,
			cell_num = uv2.eliminateNum,
			activity_id = slot4,
			difficulty_id = uv3.difficultyLevel
		})
	end

	slot0:DisposeRunGameInfo()
	slot0:SaveDefaultLevelAndDiff(uv1)
	slot0:CheckUnReciveLevelReward()
	manager.notify:Invoke(DORM_LINK_END_GAME, DormLinkGameConst.StopGameType.success, slot3)
end

function slot0.FailedClear(slot0)
	slot0:DisposeRunGameInfo()
	manager.notify:Invoke(DORM_LINK_END_GAME, DormLinkGameConst.StopGameType.fail)
end

function slot0.DisposeRunGameInfo(slot0)
	slot0:DisposeGameCacheInfo()
	slot0:DisposeTimer()

	uv0 = nil
end

function slot0.ResetRunGameInfo(slot0)
	uv0 = true

	slot0:InitCacheData()
	slot0:InitCustomerInfo()
end

function slot0.DisposeGameInfo(slot0)
	uv0 = nil
	uv1 = nil
end

function slot0.EliminateMaterial(slot0, slot1)
	slot0:ReSetBatterTimer()

	uv0 = true

	if not uv1.batterMaterial[slot1] then
		uv1.batterMaterial[slot1] = 0
	end

	uv1.eliminateNum = uv1.eliminateNum + 1
	uv1.batterMaterial[slot1] = uv1.batterMaterial[slot1] + 1

	slot0:UpdataCustomerNeed({})

	if uv2 then
		for slot6, slot7 in pairs(uv2) do
			manager.notify:Invoke(DORM_LINK_REFRESH_CUSTOMER_BUBBLE, slot6, slot2[slot6])
		end
	end

	slot0:AddBatterNum()
	slot0:RefreshBasePoint(slot1)
end

function slot0.RefreshBasePoint(slot0, slot1)
	for slot6, slot7 in pairs(uv0) do
		slot2 = 0 + slot7.satietyAddition
	end

	uv1.customerAddition = slot2

	if ActivityLinkGameCellCfg[slot1] then
		uv1.basePoint = uv1.basePoint + ActivityLinkGameCellCfg[slot1].complete_score * (100 + uv1.batterAddition + slot2) / 100
	end
end

function slot0.AddBatterNum(slot0)
	uv0.batterNum = uv0.batterNum + 1

	slot0:RefreshExtendAddition()
	slot0:RefreshGenerateInterval()
	DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.SuccssBatterNum, {
		oldNum = uv0.batterNum - 1,
		newNum = uv0.batterNum
	})
	manager.notify:Invoke(DORM_LINK_REFRESH_BATTER_NUM)
end

function slot0.ClearBatterNum(slot0)
	uv0.highestBatterNum = math.max(uv0.highestBatterNum, uv0.batterNum)

	DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.FaileBatterNum, {
		num = uv0.batterNum
	})

	uv0.batterNum = 0

	slot0:RefreshGenerateInterval()
	slot0:RefreshExtendAddition()
	manager.notify:Invoke(DORM_LINK_REFRESH_BATTER_NUM)
end

function slot0.GetBatterNum(slot0)
	return uv0.batterNum
end

function slot0.GetExtendAddition(slot0)
	return uv0.batterAddition + uv0.customerAddition
end

function slot0.RefreshExtendAddition(slot0)
	slot2 = slot0:GetExtendAddition()
	slot3 = uv1.batterNum
	uv1.batterAddition = 0

	if ActivityLinkGameCfg[uv0].hit_score_up then
		for slot7, slot8 in ipairs(slot1) do
			if slot8[1] <= slot3 then
				uv1.batterAddition = 0 + slot8[2]

				if uv1.batterAddition <= 0 then
					print("连击加成错误")
				end
			end
		end
	end

	if slot2 ~= slot0:GetExtendAddition() then
		manager.notify:Invoke(DORM_LINK_REFRESH_EXTEND_ADDITION)
	end
end

function slot0.RefreshCustomerExtendAddition(slot0)
	slot1 = slot0:GetExtendAddition()
	uv0.customerAddition = 0

	for slot5, slot6 in pairs(uv1) do
		uv0.customerAddition = uv0.customerAddition + slot6.satietyAddition
	end

	if slot1 ~= slot0:GetExtendAddition() then
		manager.notify:Invoke(DORM_LINK_REFRESH_EXTEND_ADDITION)
	end
end

function slot0.RefreshGenerateInterval(slot0)
	if not uv0 then
		print("操作数据不存在")
	end

	slot1 = uv0.batterNum
	uv0.generateInterval = ActivityLinkGameCfg[uv1].time_interval / 100

	if ActivityLinkGameCfg[uv1].hit_interval_cut then
		for slot6, slot7 in ipairs(slot2) do
			if slot7[1] <= slot1 then
				uv0.generateInterval = (ActivityLinkGameCfg[uv1].time_interval - slot7[2]) / 100

				if uv0.generateInterval <= 0 then
					print("生成间隔时间错误")
				end
			end
		end
	end
end

function slot0.GetDisposeMaterialNum(slot0, slot1)
	return uv0.batterMaterial[slot1] or 0
end

function slot0.UpdataCustomerNeed(slot0, slot1)
	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			slot8 = true

			for slot12, slot13 in ipairs(ActivityLinkGameComposeCfg[slot6.curPreference].compose_list) do
				if slot0:GetDisposeMaterialNum(slot13[1]) < slot13[2] then
					slot8 = false

					break
				end
			end

			if slot8 then
				for slot12, slot13 in ipairs(ActivityLinkGameComposeCfg[slot7].compose_list) do
					slot14 = slot13[1]
					uv1.batterMaterial[slot14] = uv1.batterMaterial[slot14] - slot13[2]
				end

				slot6:FoodComplate()
			end

			if slot1 then
				slot1[slot5] = slot8
			end
		end
	end
end

function slot0.GetCurMaterialState(slot0)
	if uv0 then
		return uv0.materialstate
	end
end

function slot0.GenerateMaterialList(slot0)
	manager.notify:Invoke(LIANLIANKAN_PREVIEW_APPEAR)
end

function slot0.ClearConveyorMaterial(slot0, slot1)
	manager.notify:Invoke(LIANLIANKAN_PREVIEW_REMOVE_ALL, slot1, true)
end

function slot0.DrainMaterial(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		uv0.drainMaterialNum = uv0.drainMaterialNum + 1
		slot2 = 0 + ActivityLinkGameCellCfg[slot7].waste_score
	end

	uv0.drainPoint = uv0.drainPoint + slot2

	if slot2 > 0 then
		manager.notify:Invoke(DORM_LINK_REFRESH_DRAIN_MATERIAL, slot2)
	end
end

function slot0.GetLastPoint(slot0)
	slot1 = uv0.basePoint

	if uv0.extendPoint - uv0.drainPoint < 0 then
		slot2 = 0
	end

	if ActivityLinkGameCfg[uv1].time_limit - uv0.gameTime < 0 then
		slot4 = 0
	end

	slot5 = slot4 * GameSetting.linkgame_time_score.value[1]

	return slot1 + slot2 + slot5, slot2 + slot5
end

function slot0.GetSaveLevelID(slot0)
	return getData(string.format("%s_%d", "DormLinkLevel", USER_ID), "levelID") or ActivityLinkGameCfg[ActivityLinkGameCfg.all[1]].id
end

function slot0.SaveDefaultLevelAndDiff(slot0, slot1)
	saveData(string.format("%s_%d", "DormLinkLevel", USER_ID), "levelID", slot1)
end

function slot0.CheckUnCompleteLevel(slot0)
	if uv0 then
		for slot4, slot5 in pairs(ActivityLinkGameCfg.get_id_list_by_activity_id) do
			if DormLinkGameTools:ChecklevelUnLock(slot5[1]) then
				slot6 = false

				for slot10, slot11 in ipairs(slot5) do
					if uv0[slot11] and uv0[slot11].maxPoint then
						slot6 = true

						break
					end
				end

				if not slot6 then
					manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_UNCOMPLETE_LEVEL, 1)

					return
				end
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_UNCOMPLETE_LEVEL, 0)
end

function slot0.CheckUnReciveLevelReward(slot0)
	for slot5, slot6 in ipairs(ActivityLinkGameRewardCfg.all) do
		if (not uv0 or uv0 and not uv0[slot6]) and DormLinkGameData:CheckLevelRewardState(slot6) == DormLinkGameConst.RewardItemState.complete then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD, 0)
end

function slot0.CheckUnReciveTaskReward(slot0)
	slot0.list_ = {}

	for slot6, slot7 in pairs(TaskTools:GetActivityTaskList(DormLinkGameTools:GetTaskActivityID(uv0)) or {}) do
		if AssignmentCfg[slot7.id].activity_id == slot1 and slot9.need <= slot7.progress and slot7.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_TASK_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_TASK_REWARD, 0)
end

return slot0
