manager.net:Bind(40005, function (slot0)
	SurveyData:InitData(slot0)
	RegressionAction.ChcekSurveyRedPoint()
end)
manager.net:Bind(40009, function (slot0)
	SurveyData:FinishSurvey(slot0.id)
	uv0.UpdateSurveyRedPoint(true)
	manager.notify:CallUpdateFunc(FINISH_SURVEY, slot0)
	RegressionAction.ChcekSurveyRedPoint()
end)
manager.net:Bind(40023, function (slot0)
	SurveyData:ReservationGame(slot0.state == 1)
end)
manager.net:Bind(40011, function (slot0)
	SurveyData:SetPraise(true)
	SurveyData:SetSourceId(slot0.source_id)
end)

return {
	Praise = function (slot0)
		manager.net:Push(40012, {
			btn = slot0
		})
	end,
	GetReward = function (slot0)
		manager.net:SendWithLoadingNew(40006, {
			id = slot0
		}, 40007, uv0.OnGetReward)
	end,
	OnGetReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SurveyData:GotReward(slot1.id)
			manager.notify:CallUpdateFunc(GET_SURVEY_GIFT, slot0, slot1)
			uv0.UpdateSurveyRedPoint()
			RegressionAction.ChcekSurveyRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	ReservationGame = function ()
		manager.net:SendWithLoadingNew(40024, {
			state = 1
		}, 40025, uv0.OnReservationGame)
	end,
	OnReservationGame = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SurveyData:ReservationGame(true)
			manager.notify:CallUpdateFunc(RESERVATION_GAME, slot0)
		else
			ShowTips(slot0.result)
		end
	end,
	SetSurveyRedPointData = function ()
		saveData("SDK", "survey", manager.time:GetServerTime())

		slot1 = {}

		for slot5, slot6 in pairs(SurveyData:GetSurveyList()) do
			table.insert(slot1, slot6.id)
		end

		saveData("SDK", "surveyList", slot1)
		uv0.UpdateSurveyRedPoint()
	end,
	UpdateSurveyRedPoint = function (slot0)
		slot1 = nil

		if not slot0 and getData("SDK", "survey") and manager.time:IsSameDay(slot2 - 18000, manager.time:GetServerTime() - 18000) then
			slot1 = 0
		end

		for slot6, slot7 in pairs(SurveyData:GetSurveyList()) do
			if slot7.type ~= 2 and not table.keyof(getData("SDK", "surveyList") or {}, slot6) then
				slot1 = 1

				break
			end
		end

		for slot7, slot8 in pairs(SurveyData:GetSurveyList()) do
			if slot8.type ~= 2 and slot8.status == 1 then
				slot1 = 1

				break
			end
		end

		if not table.keyof(OperationData:GetOperationOpenList(), OperationConst.QUESTIONNAIRE) then
			slot1 = 0
		end

		manager.redPoint:setTip(RedPointConst.SURVEY, slot1)
	end,
	FollowPlatform = function (slot0)
		manager.net:SendWithLoadingNew(40026, {
			type = slot0
		}, 40027, uv0.OnFollowPlatform)
	end,
	OnFollowPlatform = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if OperationConst.PLATFORM.BILIBILI == slot1.type then
				SurveyData:CacheFollowTip(GetTips("WEIBO_REWARD_SENT"))
			elseif OperationConst.PLATFORM.YOUTUBE == slot1.type then
				SurveyData:CacheFollowTip(GetTips("WEIBO_REWARD_SENT"))
			else
				ShowTips("WEIBO_REWARD_SENT")
			end
		elseif slot0.result == 6904 then
			ShowTips("ERROR_DISCORD_SUBSCRIB_FAILED")
		elseif OperationConst.PLATFORM.BILIBILI == slot1.type then
			SurveyData:CacheFollowTip(GetTips("ERROR_WEIBO_REWARD_COLLECTED"))
		elseif OperationConst.PLATFORM.YOUTUBE == slot1.type then
			SurveyData:CacheFollowTip(GetTips("ERROR_WEIBO_REWARD_COLLECTED"))
		else
			ShowTips("ERROR_WEIBO_REWARD_COLLECTED")
		end

		if OperationConst.PLATFORM.BILIBILI == slot1.type then
			Application.OpenURL(OperationAction.GetOperationUrl("FOLLOW_BILIBILI"))
			SDKTools.SendMessageToSDK("direction", {
				direction_type = 53,
				direction_channel = 4
			})
		end
	end
}
