slot1 = false

manager.net:Bind(59011, function (slot0)
	if not uv0 then
		uv1.InitRedPointConst(slot0.version_id)
	end

	uv0 = true

	ActivityNoobData:InitData(slot0)
	uv1.PlayerUpgradeRedPoint()
	uv1.RefreshAccumulateRedPoint()
	ActivityNewbieTools.RefreshFirstRechargeRedPoint()
	ActivityNewbieTools.RefreshMonthlyCardRedPoint()
	ActivityNewbieTools.RefreshBpRedPoint()
	TaskRedPoint:UpdateNoobTaskRedFull(ActivityNewbieTools.GetNoobTaskType())
	ActivityNewbieTools.RefreshAdvanceTaskRedPoint()
end)
manager.net:Bind(59009, function (slot0)
	if uv0 == true then
		ActivityNoobData:UpdateRecharge(slot0.newbie_recharge_reward)
		manager.notify:Invoke(NEWBIE_RECHARGE_UPDATE)
		ActivityNewbieTools.RefreshFirstRechargeRedPoint()
		ActivityNewbieTools.RefreshMonthlyCardRedPoint()
		ActivityNewbieTools.RefreshBpRedPoint()
	end
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function ()
	if uv0 == true then
		uv1.PlayerUpgradeRedPoint()
		ActivityNewbieTools.RefreshAdvanceTaskRedPoint()
	end
end)

return {
	PlayerUpgradeRedPoint = function ()
		if not uv0 then
			return
		end

		slot1 = ActivityNoobData:GetUpgradeFinishList()

		for slot5, slot6 in ipairs(GameSetting.levelup_reward.value) do
			if PlayerData:GetPlayerInfo().userLevel < slot6[1] then
				manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 0)

				return
			end

			if not table.keyof(slot1, slot7) then
				manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 0)
	end,
	NoobSignIn = function (slot0)
		manager.net:SendWithLoadingNew(59012, {}, 59013, function (slot0)
			uv0(slot0)
		end)
	end,
	ReceiveUpgradeReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(59004, {
			level = slot0
		}, 59005, function (slot0)
			uv0(slot0)
		end)
	end,
	ReceiveRechargeReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(59006, {
			type = slot0,
			reward_type = slot1
		}, 59007, function (slot0)
			if uv0 then
				uv0(slot0)
			end
		end)
	end,
	ReceiveAccumulateReward = function (slot0)
		manager.net:SendWithLoadingNew(59014, {
			id = slot0
		}, 59015, function (slot0)
			if isSuccess(slot0.result) then
				ActivityNoobData:SetAccumulateReceivedList(uv0)
				uv1.RefreshAccumulateRedPoint()
				getReward2(slot0.reward_list)
				manager.notify:Invoke(NOOB_ACCUMULATE_RECEIVE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPointConst = function (slot0)
		slot1 = {}

		for slot5 = 1, 2 do
			slot1[#slot1 + 1] = string.format("%s_%d", RedPointConst.NEWBIE_SIGN, slot5)
		end

		manager.redPoint:addGroup(RedPointConst.NEWBIE_SIGN, slot1)

		if (NoobVersionCfg[slot0] or NoobVersionCfg[2]).noob_task_type ~= 0 then
			slot5 = {}

			for slot9 = 1, #TaskTools:GetNoobPhaseTask(slot2.noob_task_type) do
				slot5[#slot5 + 1] = string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot9)
			end

			slot5[#slot5 + 1] = RedPointConst.NOOB_TASK_ACCUMULATE

			manager.redPoint:addGroup(RedPointConst.NEWBIE_TASK, slot5)
		end
	end,
	RefreshAccumulateRedPoint = function ()
		for slot7, slot8 in pairs(TaskTools:GetNoobCompletedList(NoobVersionCfg[ActivityNewbieTools.GetVersionID()].noob_task_type)) do
			slot3 = 0 + slot8
		end

		for slot9, slot10 in ipairs(ActivityNewbieTools.GetNoobPorgressRewardList()) do
			if slot10[1] <= slot3 and not (ActivityNoobData:GetAccumulateReceivedList() or {})[slot9] then
				manager.redPoint:setTip(RedPointConst.NOOB_TASK_ACCUMULATE, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.NOOB_TASK_ACCUMULATE, 0)
	end
}
