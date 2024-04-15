manager.net:Bind(80051, function (slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.choose_list) do
		table.insert(slot1, {
			chanceItemID = slot6.id,
			state = slot6.state,
			ispre = slot6.is_pre
		})
	end

	NewWarChessData:SetChanceInfo(slot0.chance_id, slot1)
end)
manager.net:Bind(80055, function (slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.hero) do
		table.insert(slot1, {
			slot6.id,
			slot6.hp_ratio
		})
	end

	NewWarChessData:SetServerHeroList(slot1)
end)
manager.net:Bind(80057, function (slot0)
	slot1 = NewWarChessData:GetCurrentWarChessMapID()

	NewWarChessData:SetCurMapExploreValue(slot1, slot0.exchange_point)

	if NewWarChessData:GetExploreValue(slot1) < 100 and slot0.exchange_point >= 100 then
		ShowMessageBox({
			content = GetTips("ACTIVITY_NEW_WARCHESS_EXPLORE_MAX"),
			OkCallback = function ()
				NewChessTools.ExitNewChessScene(false)
			end,
			BtnText = {
				"1",
				"2",
				"3"
			}
		})
	end

	uv0.UpdateNewWarChessExploreRewardRedPoint()
	manager.notify:CallUpdateFunc(NEWWARCHESS_EXPLOREVALUE_UPDATE, slot0.exchange_point)
end)
manager.net:Bind(80059, function (slot0)
	slot1 = {
		timing = slot0.event_pool.type,
		timingParams = cleanProtoTable(slot0.event_pool.param),
		eventList = {}
	}

	for slot5, slot6 in ipairs(slot0.event_pool.event_list) do
		slot7 = {
			eventID = slot12.integer,
			params = {}
		}

		for slot11, slot12 in ipairs(slot6.event_pool) do
			if slot11 == 1 then
				table.insert(slot7.params, cleanProtoTable(slot6.params))
			elseif slot12.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.INT then
				table.insert(slot7.params, slot12.integer)
			elseif slot12.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.ARRAY then
				table.insert(slot7.params, cleanProtoTable(slot12.array))
			elseif slot12.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.ARRAY2 then
				slot13 = {}

				for slot17, slot18 in ipairs(slot12.array2) do
					table.insert(slot13, cleanProtoTable(slot18.array))
				end

				table.insert(slot7.params, slot13)
			elseif slot12.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.TYPEID_AND_EVENTINFO then
				slot13 = {}

				for slot17, slot18 in ipairs(slot12.array3) do
					table.insert({}, slot18.integer)

					slot20 = {}

					for slot24, slot25 in ipairs(slot18.two_array) do
						table.insert(slot20, cleanProtoTable(slot25.array))
					end

					table.insert(slot19, slot20)
					table.insert(slot13, slot19)
				end

				table.insert(slot7.params, slot13)
			elseif slot12.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.TYPEIDLIST_AND_EVENTINFO then
				slot13 = {}

				for slot17, slot18 in ipairs(slot12.array4) do
					slot19 = {}
					slot20 = {}

					for slot24, slot25 in ipairs(slot18.list) do
						table.insert(slot20, slot25)
					end

					table.insert(slot19, slot20)

					slot21 = {}

					for slot25, slot26 in ipairs(slot18.two_array) do
						table.insert(slot21, cleanProtoTable(slot26.array))
					end

					table.insert(slot19, slot21)
					table.insert(slot13, slot19)
				end

				table.insert(slot7.params, slot13)
			end
		end

		table.insert(slot1.eventList, slot7)
	end

	NewWarChessData:AddServerEvent(slot1)
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function ()
	uv0.UpdateNewWarChessTaskRedPoint()
end)
manager.net:Bind(80060, function (slot0)
	if manager.NewChessManager then
		slot1 = {}

		for slot5, slot6 in ipairs(slot0.global_event.event_pos) do
			table.insert(slot1, {
				slot6.x,
				slot6.z
			})
		end

		manager.NewChessManager.globalManager_:UpdateGlobalEventServerData(slot0.global_event.global_event_id, slot0.global_event.status, slot1)
	end
end)
manager.net:Bind(80115, function (slot0)
	uv0.InitRedPoint()
	NewWarChessData:SetSystemServerData(slot0)
	manager.notify:CallUpdateFunc(NEWWARCHESS_LEVEL_INFO_UPDATE)
	NewWarChessData:FixCurMapNewDayMovePoint()
	uv0.UpdateNewWarChessRedPoint()
end)

return {
	EnterChessMap = function ()
		NewChessTools.InitNewChessConfig()

		slot0 = GetNewChessDataForExcehange()
		slot1 = NewWarChessData:GetCurrentWarChessMapData()
		slot0.mapId = slot1.mapId
		slot0.bronPos = Vector2(slot1.bronPos.x, slot1.bronPos.z)
		slot0.direction = slot1.direction
		slot2 = NewWarChessLevelCfg[slot0.mapId]
		slot3 = NewMapConfig.New()
		slot3.mapId = slot0.mapId
		slot3.sceneId = slot2.scene_id
		slot3.minFreeLookX = slot2.freelook_range[1][1]
		slot3.maxFreeLookX = slot2.freelook_range[1][2]
		slot3.minFreeLookZ = slot2.freelook_range[2][1]
		slot3.maxFreeLookZ = slot2.freelook_range[2][2]
		slot3.modelName = slot2.model
		slot3.modelScale = tonumber(slot2.model_scale)
		slot0.MapConfig = slot3
		slot4 = {
			[slot8] = slot10
		}

		for slot8, slot9 in pairs(slot1.mapChangeInfo) do
			slot10 = NewGridChangeData.New()
			slot10.tag = slot9.tag
			slot10.x = slot9.pos.x
			slot10.z = slot9.pos.z
			slot10.rotationY = slot9.direction * 60
		end

		for slot8, slot9 in pairs(slot1.objectChangeInfo) do
			if slot4[slot8] then
				slot4[slot8].objecttag = slot9.objecttag
				slot4[slot8].objectRotationY = slot9.objectdirection * 60
			else
				slot10 = NewGridChangeData.New()
				slot10.tag = -1
				slot10.x = slot9.pos.x
				slot10.z = slot9.pos.z
				slot10.objecttag = slot9.objecttag
				slot10.objectRotationY = slot9.objectdirection * 60
				slot4[slot8] = slot10
			end
		end

		slot5 = {}

		for slot9, slot10 in pairs(slot4) do
			table.insert(slot5, slot10)
		end

		slot0.mapInfoS = slot5
		slot0.fogInfo = slot1.fogInfo
		slot6 = {}

		if slot2.cache_asset and type(slot2.cache_asset) == "table" then
			for slot10, slot11 in ipairs(slot2.cache_asset) do
				slot12 = NewCacheAssetInfo.New()
				slot12.assetPath = slot11
				slot12.num = 1

				table.insert(slot6, slot12)
			end
		end

		slot0.cacheAssetS = slot6

		StartNewChessBattleMode()
	end,
	RoleMoveByPos = function (slot0, slot1)
		manager.net:SendWithLoadingNew(80100, {
			next_pos = slot0
		}, 80101, function (slot0, slot1)
			uv0.OnRoleMoveByPos(slot0, slot1, uv1)
		end)
	end,
	OnRoleMoveByPos = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot2 then
				slot2(true)
			end
		else
			ShowTips(slot0.result)

			if slot2 then
				slot2(false)
			end
		end
	end,
	OpenFogByPos = function (slot0, slot1, slot2)
		manager.net:Push(80110, {
			central_pos = slot0,
			fog = slot1
		}, 80111, function (slot0, slot1)
			uv0.OnOpenFogByPos(slot0, slot1, uv1)
		end)
	end,
	OnOpenFogByPos = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot2 then
				slot2(true)
			end
		else
			ShowTips(slot0.result)

			if slot2 then
				slot2(false)
			end
		end
	end,
	EnterNewWarChess = function (slot0)
		NewWarChessData:SetTemporaryData("CurEnterMapID", slot0)
		manager.net:SendWithLoadingNew(80030, {
			chapter_id = slot0
		}, 80031, uv0.OnEnterNewWarChess)
	end,
	OnEnterNewWarChess = function (slot0, slot1)
		if isSuccess(slot0.result) then
			NewWarChessData:SetWarChessData(slot1.chapter_id, slot0.map)
			uv0.EnterChessMap()
		else
			ShowTips(slot0.result)
		end

		NewWarChessData:SetTemporaryData("CurEnterMapID", nil)
	end,
	ClickGrid = function (slot0, slot1, slot2, slot3)
		slot4 = 0

		if slot2 then
			slot4 = 1
		end

		manager.net:SendWithLoadingNew(80102, {
			pos = {
				x = slot0,
				z = slot1
			},
			is_far = slot4
		}, 80103, function (slot0, slot1)
			uv0.OnClickGrid(slot0, slot1, uv1)
		end)
	end,
	OnClickGrid = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot2 then
				slot2()
			end
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SelectChanceItem = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(80104, {
			choose_id = slot0,
			dice_list = slot1
		}, 80105, function (slot0, slot1)
			uv0.OnSelectChanceItem(slot0, slot1, uv1)
		end)
	end,
	OnSelectChanceItem = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot2 then
				slot2()
			end
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	UseDiceSkill = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in ipairs(slot1) do
			table.insert(slot3, slot8)
		end

		manager.net:SendWithLoadingNew(80106, {
			skill_id = slot0,
			dice_list = slot3
		}, 80107, function (slot0, slot1)
			if isSuccess(slot0.result) then
				uv0.OnUseDiceSkill(slot0, slot1, uv1)

				slot2 = {}

				if slot0.dice_list then
					for slot6, slot7 in ipairs(slot0.dice_list) do
						table.insert(slot2, slot7)
					end
				end

				uv0.AddNewDice(slot2)
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	OnUseDiceSkill = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			ShowTips("ACTIVITY_NEW_WARCHESS_USE_SKILL_SUCCESS")

			if slot2 then
				slot2()
			end
		else
			ShowTips(slot0.result)
		end
	end,
	FinishTask = function (slot0, slot1)
		manager.net:SendWithLoadingNew(80108, {
			task_id = slot0
		}, 80109, function (slot0, slot1)
			uv0.OnFinishTask(slot0, slot1, uv1)
		end)
	end,
	OnFinishTask = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot2 then
				slot2()
			end
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	DiceToMovePoint = function (slot0, slot1)
		manager.net:SendWithLoadingNew(80112, {
			dice = slot0
		}, 80113, function (slot0, slot1)
			uv0.OnDiceToMovePoint(slot0, slot1, uv1)
		end)
	end,
	OnDiceToMovePoint = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot2 then
				slot2()
			end
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	AddNewDice = function (slot0)
		NewWarChessData:ReCacheDiceData()

		slot1 = false

		for slot5 = 1, #slot0 do
			slot1 = uv0.AddSingleDice(slot0[slot5])
		end

		if slot1 then
			ShowTips("ACTIVITY_NEW_WARCHESS_DICE_MAX")
		end

		manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
	end,
	AddSingleDice = function (slot0)
		if NewWarChessData:CheckDiceNum() then
			slot2 = slot0
			slot3 = math.floor(slot2 * NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000)

			NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", slot3)
			manager.NewChessManager:CreateTips({
				tipsType = NewChessConst.TIPS_TYPE.SWITCH,
				tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), slot2, slot3),
				tipsDiceNum = slot2
			})
		else
			NewWarChessData:AddDice(slot0)

			if manager.NewChessManager then
				manager.NewChessManager:CreateTips({
					tipsType = NewChessConst.TIPS_TYPE.DICE,
					tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_DICE"), slot0),
					tipsDiceNum = slot0
				})
			end
		end

		return slot1
	end,
	GetActivityReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(80116, {
			activity_id = slot1,
			chapter_id = slot0,
			value_list = slot2
		}, 80117, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot2 = {}

				for slot6, slot7 in ipairs(slot0.item_list) do
					table.insert(slot2, {
						slot7.id,
						slot7.num
					})
				end

				sortMergeGetReward(slot2)

				for slot6, slot7 in pairs(uv0) do
					NewWarChessData:ReceiveReward(uv1, slot7)
				end

				uv2.UpdateNewWarChessExploreRewardRedPoint()
				manager.notify:Invoke(ACTIVITY_NEWWARCHESS_REWARD_UPDATE, uv1, uv0)
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	InitRedPoint = function ()
		slot3 = ActivityTemplateConst.NEW_WARCHESS

		for slot3, slot4 in pairs(ActivityCfg.get_id_list_by_activity_template[slot3]) do
			if ActivityData:GetActivityIsOpen(slot4) then
				slot5 = RedPointConst.NEW_WARCHESS .. "_" .. slot4
				slot6 = RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. slot4
				slot7 = RedPointConst.NEW_WARCHESS_TASK_REWARD .. "_" .. slot4
				slot8 = RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. slot4
				slot9 = {}

				for slot13, slot14 in pairs(ActivityCfg[slot4].sub_activity_list) do
					table.insert(slot9, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. slot14)
				end

				manager.redPoint:addGroup(slot8, slot9)
				manager.redPoint:addGroup(slot5, {
					slot6,
					slot7,
					slot8
				})
			end
		end
	end,
	UpdateNewWarChessRedPoint = function ()
		uv0.UpdateNewWarChessNewMapRedPoint()
		uv0.UpdateNewWarChessTaskRedPoint()
		uv0.UpdateNewWarChessExploreRewardRedPoint()
	end,
	UpdateNewWarChessNewMapRedPoint = function ()
		slot3 = ActivityTemplateConst.NEW_WARCHESS

		for slot3, slot4 in pairs(ActivityCfg.get_id_list_by_activity_template[slot3]) do
			slot5 = RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. slot4

			if ActivityData:GetActivityIsOpen(slot4) then
				slot7 = false

				for slot11, slot12 in pairs(ActivityCfg[slot4].sub_activity_list) do
					if NewWarChessLevelCfg.get_id_list_by_activity[slot12] then
						slot13 = NewWarChessLevelCfg.get_id_list_by_activity[slot12][1]

						if NewWarChessData:GetExploreValue(slot13) == 0 and NewWarChessData:GetLevelIsFinish(NewWarChessLevelCfg[slot13].front_level_id) == true then
							slot7 = true

							break
						end
					end
				end

				if slot7 then
					manager.redPoint:setTip(slot5, 1)
				else
					manager.redPoint:setTip(slot5, 0)
				end
			else
				manager.redPoint:setTip(slot5, 0)
			end
		end
	end,
	UpdateNewWarChessTaskRedPoint = function ()
		slot3 = ActivityTemplateConst.NEW_WARCHESS

		for slot3, slot4 in pairs(ActivityCfg.get_id_list_by_activity_template[slot3]) do
			if ActivityData:GetActivityIsOpen(slot4) then
				if #TaskTools:GetCanGetActivityTaskList(slot4) > 0 then
					manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_TASK_REWARD .. "_" .. slot4, 1)
				else
					manager.redPoint:setTip(slot5, 0)
				end
			else
				manager.redPoint:setTip(slot5, 0)
			end
		end
	end,
	UpdateNewWarChessExploreRewardRedPoint = function ()
		slot3 = ActivityTemplateConst.NEW_WARCHESS

		for slot3, slot4 in pairs(ActivityCfg.get_id_list_by_activity_template[slot3]) do
			if ActivityData:GetActivityIsOpen(slot4) then
				for slot9, slot10 in pairs(ActivityCfg[slot4].sub_activity_list) do
					if ActivityData:GetActivityIsOpen(slot10) then
						slot11 = false
						slot12 = RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. slot10
						slot13 = NewWarChessLevelCfg.get_id_list_by_activity[slot10][1]

						for slot18, slot19 in pairs(NewWarChessLevelCfg[slot13].explore) do
							if slot19 <= NewWarChessData:GetExploreValue(slot13) and NewWarChessData:GetRewardIsGet(slot13, slot19) == false then
								slot11 = true

								break
							end
						end

						if slot11 then
							manager.redPoint:setTip(slot12, 1)
						else
							manager.redPoint:setTip(slot12, 0)
						end
					end
				end
			end
		end
	end
}
