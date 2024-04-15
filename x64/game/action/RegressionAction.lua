manager.net:Bind(62001, function (slot0)
	RegressionData:InitData(slot0)
	uv0.CheckTaskRedPoint()
	uv0.CheckSignRedPoint()
	uv0.ChcekSurveyRedPoint()
	uv0.CheckBPRedPoint()
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function ()
	uv0.CheckTaskRedPoint()
end)

return {
	QuerySign = function (slot0)
		manager.net:SendWithLoadingNew(62002, {
			index = slot0
		}, 62003, uv0.OnSignBack)
	end,
	OnSignBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward2(slot0.item_list)
			RegressionData:UpdateSign(slot1.index)
			manager.notify:CallUpdateFunc(REGRESSION_SIGN)
			uv0.CheckSignRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRegressionGift = function ()
		manager.net:SendWithLoadingNew(62004, {}, 62005, uv0.OnRegressionGiftBack)
	end,
	OnRegressionGiftBack = function (slot0)
		if isSuccess(slot0.result) then
			RegressionData:UpdateRegressionGift()
			getReward2(slot0.item_list, nil, function ()
				gameContext:Back()
				uv0.CheckRegressionStory()
			end, true)
			manager.notify:CallUpdateFunc(REGRESSION_GIFT_REWAD)
		else
			ShowTips(slot0.result)
		end
	end,
	SetAccumulateCurrency = function (slot0)
		RegressionData:SetAccumulateCurrency(slot0)
		uv0.CheckBPRedPoint()
	end,
	SetBPTaskIsRecharge = function ()
		RegressionData:SetBPTaskIsRecharge()
		uv0.CheckBPRedPoint()
	end,
	CheckTaskRedPoint = function ()
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE), 0)

			return
		end

		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_DAILY, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_WEEK, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_CHALLENGE, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
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
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 0)

			return
		end

		for slot4 = 1, RegressionData:GetSignIndex() do
			if not RegressionData:IsSignReward(slot4) then
				manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 0)
	end,
	ChcekSurveyRedPoint = function ()
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 0)

			return
		end

		for slot4, slot5 in pairs(SurveyData:GetSurveyList()) do
			if slot5.type == 2 and slot5.start_time <= manager.time:GetServerTime() and slot6 <= slot5.stop_time and (slot5.status == 0 or slot5.status == 1) then
				manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 0)
	end,
	CheckBPRedPoint = function ()
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(RedPointConst.REGRESSION_BP, 0)

			return
		end

		slot2 = RegressionData:GetBPTaskStatus()
		slot5 = false

		for slot9, slot10 in ipairs(RegressionCfg[RegressionData:GetRegressionVersion()].regression_bp) do
			if RegressionBPTaskCfg[slot10].need <= RegressionData:GetAccumulateCurrency() and (slot2[slot10] == nil or slot2[slot10].is_receive_reward < 1 or RegressionData:GetBPTaskIsRecharge() >= 1 and slot2[slot10].is_receive_recharge_reward < 1) then
				slot5 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.REGRESSION_BP, slot5 and 1 or 0)
	end,
	ReceiveBPReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(62008, {
			bp_submit = slot0
		}, 62009, function (slot0, slot1)
			if isSuccess(slot0.result) then
				getReward2(mergeReward2(slot0.item_list))
				RegressionData:SetBPTaskStatus(slot1.bp_submit)
				uv0.CheckBPRedPoint()

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RegressionCapsuleToysDraw = function (slot0, slot1)
		manager.net:SendWithLoadingNew(62006, {
			times = slot0
		}, 62007, function (slot0, slot1)
			if uv0 then
				uv0(slot0, slot1)
			end
		end)
	end,
	CheckRegressionStory = function (slot0)
		slot1 = GameSetting.regression_story.value[1]
		slot2 = StoryCfg[slot1]
		slot3 = VideoTrackCfg[slot1 .. ".usm"]

		if IllustratedData:GetPlotInfo()[slot1] and slot4.is_view == 1 then
			JumpTools.OpenPageByJump("/regressionNew", slot0)
		else
			gameContext:Go("/blank")
			manager.story:StartStoryById(slot1, function (slot0)
				IllustratedAction.ViewIllustration(uv0, CollectConst.PLOT)
				JumpTools.OpenPageByJump("/regressionNew", uv1)
			end)
		end
	end
}
