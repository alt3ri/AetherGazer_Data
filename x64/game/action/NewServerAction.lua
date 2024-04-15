slot1 = false

manager.net:Bind(83101, function (slot0)
	if not uv0 then
		uv0 = true

		uv1.InitRedPointConst()
	end

	NewServerData:InitData(slot0)
	uv1.CheckTaskRedPoint()
	uv1.CheckSignRedPoint()
	uv1.CheckBPRedPoint()
end)
manager.net:Bind(83109, function (slot0)
	NewServerData:SetAccumulateCurrency(slot0.acc_num)
	uv0.CheckBPRedPoint()
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function ()
	uv0.CheckTaskRedPoint()
end)

return {
	QuerySign = function (slot0)
		manager.net:SendWithLoadingNew(83102, {
			index = slot0,
			activity_id = ActivityConst.ACTIVITY_NEW_SERVER
		}, 83103, uv0.OnSignBack)
	end,
	OnSignBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.index

			getReward2(slot0.item_list)
			NewServerData:UpdateSign(slot2)
			manager.notify:CallUpdateFunc(NEW_SERVER_SIGN, slot2)
			uv0.CheckSignRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	SetBPTaskIsRecharge = function ()
		NewServerData:SetBPTaskIsRecharge()
		uv0.CheckBPRedPoint()
	end,
	CheckTaskRedPoint = function ()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE), 0)

			return
		end

		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.NEW_SERVER_DAILY, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.NEW_SERVER_WEEK, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
	end,
	UpdateTaskRedTip = function (slot0, slot1)
		for slot6, slot7 in pairs(TaskData2:GetTaskIDListByType(slot0)) do
			slot8 = TaskData2:GetTask(slot6)

			if AssignmentCfg[slot8.id].need <= slot8.progress and slot8.complete_flag < 1 then
				manager.redPoint:setTip(slot1, 1)

				return true
			end
		end

		manager.redPoint:setTip(slot1, 0)
	end,
	CheckSignRedPoint = function ()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SIGN, 0)

			return
		end

		for slot4 = 1, NewServerData:GetSignIndex() do
			if not NewServerData:IsSignReward(slot4) then
				manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SIGN, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SIGN, 0)
	end,
	CheckBPRedPoint = function ()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_BP, 0)

			return
		end

		slot1 = NewServerData:GetBPTaskStatus()
		slot4 = false

		for slot8, slot9 in ipairs(NewServerCfg[ActivityConst.ACTIVITY_NEW_SERVER].bp) do
			if NewServerBPTaskCfg[slot9].need <= NewServerData:GetAccumulateCurrency() and (slot1[slot9] == nil or slot1[slot9].is_receive_reward < 1 or NewServerData:GetBPTaskIsRecharge() >= 1 and slot1[slot9].is_receive_recharge_reward < 1) then
				slot4 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_BP, slot4 and 1 or 0)
	end,
	ReceiveBPReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(83106, {
			activity_id = NewServerData:GetActivityID(),
			bp_submit = slot0
		}, 83107, function (slot0, slot1)
			if isSuccess(slot0.result) then
				getReward2(mergeReward2(slot0.item_list))
				NewServerData:SetBPTaskStatus(slot1.bp_submit)
				uv0.CheckBPRedPoint()

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	CapsuleToysDraw = function (slot0, slot1)
		manager.net:SendWithLoadingNew(83104, {
			times = slot0,
			activity_id = ActivityConst.ACTIVITY_NEW_SERVER
		}, 83105, function (slot0, slot1)
			if uv0 then
				uv0(slot0, slot1)
			end
		end)
	end,
	InitRedPointConst = function ()
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_NEW_SERVER, {
			RedPointConst.ACTIVITY_NEW_SERVER_SIGN,
			RedPointConst.ACTIVITY_NEW_SERVER_TASK,
			RedPointConst.ACTIVITY_NEW_SERVER_BP,
			RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE
		})
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_NEW_SERVER_TASK, {
			string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY),
			string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK),
			string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE)
		})
	end
}
