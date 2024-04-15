slot1 = false

manager.notify:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityCelebrationOrderCfg.get_id_list_by_activity_id[slot0] and ActivityData:GetActivityData(slot0):IsActivitying() and ActivityCelebrationOrderCfg[ActivityCelebrationOrderCfg.get_id_list_by_activity_id[slot0][1]].type == 2 then
		ActivityPushBoxData:ReBuild(slot3.main_activity)
		manager.notify:CallUpdateFunc(ACTIVITY_PUSH_BOX_MAP_REFRESH)
	end
end)

return {
	Init = function ()
		ActivityPushBoxData:Init()

		if uv0 then
			return
		end

		manager.net:Bind(11083, function (slot0)
			ActivityPushBoxData:SetCakeData(slot0)
			ActivityPushBoxAction.RefreshRedPoint(slot0.activity_id)
		end)
		manager.net:Bind(11091, function (slot0)
			ActivityPushBoxData:SetActivityData(slot0)
			ActivityPushBoxAction.RefreshRedPoint(slot0.activity_id)
			ActivityPushBoxData:ReBuild(slot0.activity_id)
			manager.notify:Invoke(ACTIVITY_ICON_CHANGE)
			manager.notify:CallUpdateFunc(ACTIVITY_PUSH_BOX_MAP_REFRESH)
		end)
		manager.notify:RegistListener(MATERIAL_MODIFY, function (slot0)
			for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_PUSH_BOX]) do
				if ActivityData:GetActivityData(slot6):IsActivitying() then
					ActivityPushBoxAction.RefreshMaterialRedPoint(slot6)
				end
			end
		end)

		uv0 = true
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. slot0, {
			RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK,
			RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. slot0,
			RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. slot0
		})
	end,
	StartMaking = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11084, {
			activity_id = slot0,
			cake_id = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0][slot1]
		}, 11085, uv0.OnStartMaking)
	end,
	OnStartMaking = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot7, slot8 in ipairs(ActivityCelebrationCakeCfg[slot1.cake_id].cost_list) do
				MaterialData:ModifyNum(slot8[1], -1 * slot8[2])
			end

			slot4 = {}

			for slot8, slot9 in ipairs(slot0.rewards or {}) do
				table.insert(slot4, {
					id = slot9.id,
					num = slot9.num
				})
			end

			ActivityPushBoxData:SetCakeData({
				sign = 1,
				activity_id = slot1.activity_id,
				cake_id = slot1.cake_id
			})
			getRewardData(slot4)
			ActivityPushBoxAction.RefreshMaterialRedPoint(slot1.activity_id)
			manager.notify:CallUpdateFunc(ACTIVITY_PUSH_BOX_MAKE_CAKE, slot4)
		else
			ShowTips(slot0.result)
		end
	end,
	ResetEvent = function (slot0)
		manager.net:SendWithLoadingNew(11086, {
			activity_id = slot0
		}, 11087, uv0.OnResetEvent)
	end,
	OnResetEvent = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	FinishPushBox = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11088, {
			activity_id = slot0,
			order_id = slot1
		}, 11089, uv0.OnFinishPushBox)
	end,
	OnFinishPushBox = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot6, slot7 in ipairs(slot0.rewards or {}) do
				table.insert(slot2, {
					slot7.id,
					slot7.num
				})
			end

			for slot7, slot8 in ipairs(slot2) do
				if ItemConst.LIMIT_TIME_ITEM[ItemCfg[slot8[1]].sub_type] then
					slot10 = slot9.time
				else
					slot3[slot7] = slot8
				end
			end

			PushBoxTool:SendSdk(slot1.activity_id, ActivityCelebrationOrderCfg[slot1.order_id].param, 1)
			ActivityPushBoxData:FinishPushBox(slot1.activity_id, slot1.order_id)
			JumpTools.OpenPageByJump("pushBoxResult", {
				activityID = slot1.activity_id,
				rewardList = {
					[slot7] = {
						slot9.param[1],
						slot8[2],
						0,
						_G.gameTimer:GetNextWeekFreshTime() + slot10[2][1] * 604800 + (slot10[2][2][1] - 1) * 24 * 3600 + (slot10[2][2][2] - 5) * 3600
					}
				}
			})
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshRedPoint = function (slot0)
		ActivityPushBoxAction.RefreshFatigueRedPoint(slot0)
		ActivityPushBoxAction.RefreshMaterialRedPoint(slot0)
	end,
	RefreshFatigueRedPoint = function (slot0)
		slot1 = {}

		for slot7, slot8 in pairs(TaskTools:GetActivityTaskList(ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK) or {}) do
			if slot8.complete_flag == 0 then
				table.insert(slot1, slot7)
			end
		end

		if #slot1 <= 0 and ActivityPushBoxData:GetCurIndex(slot0) >= #(ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0] or {}) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. slot0, 0)

			return
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. slot0, PushBoxTool:GetFatigueMax(slot0) <= ActivityPushBoxData:GetFatigue(slot0) and 1 or 0)
	end,
	RefreshMaterialRedPoint = function (slot0)
		if ActivityPushBoxData:GetCurIndex(slot0) >= #ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0] then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. slot0, 0)

			return
		end

		for slot7, slot8 in ipairs(ActivityCelebrationCakeCfg[slot2[slot1 + 1]].cost_list) do
			if ItemTools.getItemNum(slot8[1]) < slot8[2] then
				manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. slot0, 0)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. slot0, 1)
	end
}
