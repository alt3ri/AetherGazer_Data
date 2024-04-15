slot1 = false

return {
	Init = function ()
		ActivityPtScrollData:Init()

		if uv0 then
			return
		end

		manager.net:Bind(76151, function (slot0)
			ActivityPtScrollData:SetData(slot0)
			ActivityPtScrollAction.RefreshRedPoint(slot0.activity_id)
		end)

		uv0 = true
	end,
	SetSelectSuit = function (slot0, slot1)
		manager.net:SendWithLoadingNew(76152, {
			activity_id = slot0,
			up_select = slot1
		}, 76153, uv0.OnSetSelectSuit)
	end,
	OnSetSelectSuit = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityPtScrollData:SetUpSelect(slot1.activity_id, slot1.up_select)
			manager.notify:CallUpdateFunc(ACTIVITY_PT_SCROLL_SELECT_SUIT)
		else
			ShowTips(slot0.result)
		end
	end,
	TryToSubmitScrollTask = function (slot0, slot1)
		manager.net:SendWithLoadingNew(76154, {
			activity_id = slot0,
			times = math.floor(ActivityPtScrollData:GetClearTime(slot0) / GameSetting.activity_pt_roulette_task_times.value[1]),
			assignment_id_list = slot1 or {}
		}, 76155, uv0.OnTryToSubmitScrollTask)
	end,
	OnTryToSubmitScrollTask = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot6, slot7 in ipairs(slot0.reward_list) do
				table.insert({}, {
					slot7.id,
					slot7.num
				})
			end

			slot3 = slot1.activity_id
			slot9 = slot3
			slot10 = ActivityPtScrollData:GetClearTime(slot3) % GameSetting.activity_pt_roulette_task_times.value[1]

			ActivityPtScrollData:ModifyClearTime(slot9, slot10)

			for slot9, slot10 in ipairs(slot1.assignment_id_list) do
				TaskData2:SubmitTask(slot10)
				table.insertto(slot2, AssignmentCfg[slot10].reward or {})
			end

			if #mergeReward(formatRewardCfgList(slot2)) > 0 then
				getReward(slot2)
			end

			TaskAction:OnTaskChange(TaskAction:PackTaskIdListToTaskList(slot1.assignment_id_list))
		else
			ShowTips(slot0.result)
		end
	end,
	InitRedPointKey = function (slot0)
		if not ActivityData:GetActivityData(slot0) or not slot1:IsActivitying() then
			return
		end

		if not ActivityPtScrollTools.GetTaskActivityID(slot0) then
			return
		end

		manager.redPoint:addGroup(RedPointConst.ACTIVITY_PT_SCROLL .. "_" .. slot0, {
			RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. slot0,
			RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. slot0,
			RedPointConst.ACTIVITY_TASK .. "_" .. slot2
		})
	end,
	RefreshRedPoint = function (slot0)
		if not ActivityData:GetActivityData(slot0) or not slot1:IsActivitying() then
			ActivityPtScrollAction.ClearRed(slot0)

			return
		end

		if not ActivityPtScrollTools.GetTaskActivityID(slot0) then
			return
		end

		slot3 = false

		if ActivityTools.IsUnlockActivity(slot0) and not (getData(RedPointConst.ACTIVITY_PT_SCROLL_OPEN, tostring(slot0)) or false) then
			slot3 = true
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. slot0, slot3 and 1 or 0)
	end,
	ClearRed = function (slot0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. slot0, 0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. slot0, 0)
	end
}
