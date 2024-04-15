return {
	Init = function ()
		manager.net:Bind(64087, function (slot0)
			ActivityRecallData:InitActivityRecallData(slot0)
			manager.notify:CallUpdateFunc(RECALL_REWARD_UPDATE)
		end)
		manager.net:Bind(64095, function (slot0)
			ActivityRecallData:InitActivityRecalledData(slot0)
		end)
		manager.net:Bind(64115, function (slot0)
			ActivityRecallData:InitRecalledSignData(slot0)
			manager.notify:CallUpdateFunc(RECALL_SIGN_UPDATE)
		end)
	end,
	RequireRecallReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64088, {
			activity_id = slot0,
			id = slot1
		}, 64089, uv0.RequireRecallRewardCallback)
	end,
	RequireRecallRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateRecallRewardList(slot1.id)
			JumpTools.GoToSystem("RecallRewardPop", {
				list = slot0.reward_list
			})
			manager.notify:CallUpdateFunc(RECALL_REWARD_UPDATE)
			ActivityRecallData:UpdateRecallRewardRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireRecallInfo = function (slot0)
		manager.net:SendWithLoadingNew(64090, {
			activity_id = slot0
		}, 64091, uv0.RequireRecallInfoCallback)
	end,
	RequireRecallInfoCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateUserInfoList(slot0)
			JumpTools.GoToSystem("RecallInfoPop", nil)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireRecallShareCode = function (slot0)
		manager.net:SendWithLoadingNew(64092, {
			activity_id = slot0
		}, 64093, uv0.RequireRecallShareCodeCallback)
	end,
	RequireRecallShareCodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			UnityEngine.GUIUtility.systemCopyBuffer = ActivityRecallData:GetDataByPara("recallCode")

			ActivityRecallData:UpdateTaskData()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireWriteRecallCode = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64096, {
			activity_id = slot0,
			recall_code = slot1
		}, 64097, uv0.RequireWriteRecallCodeCallback)
	end,
	RequireWriteRecallCodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateRecallUserInfo(slot0)
			manager.notify:CallUpdateFunc(RECALL_CODE_UPDATE)
			JumpTools.GoToSystem("RecallRewardPop", {
				list = slot0.reward_list
			})
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireRecalledSign = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64098, {
			activity_id = slot0,
			sign_day = slot1
		}, 64099, uv0.RequireRecalledSignCallback)
	end,
	RequireRecalledSignCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateSignData(slot1.sign_day)

			slot2 = ActivityRecallData:GetDataByPara("signData")

			JumpTools.GoToSystem("RecallRewardPop", {
				list = slot0.reward_list
			})
			ActivityRecallData:UpdateSignRedPoint()
			manager.notify:CallUpdateFunc(RECALL_SIGN_UPDATE)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RecallShare = function (slot0, slot1)
		manager.net:SendWithLoadingNew(27600, {
			recommend = slot0
		}, 27601, function (slot0)
			uv0(slot0)
		end)
	end,
	RequestOpenRecallView = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64116, {
			main_activity_id = slot0
		}, 64117, function (slot0, slot1)
			if isSuccess(slot0.result) and uv0 then
				uv0()
			end
		end)
	end
}
