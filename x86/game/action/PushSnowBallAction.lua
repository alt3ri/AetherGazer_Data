manager.net:Bind(78001, function (slot0)
	PushSnowBallData:InitFromServer(slot0)
	uv0.InitRedPoint()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
		uv0.UpdateRedPoint()
	end)
end)
manager.net:Bind(78005, function (slot0)
	PushSnowBallData:OnReceviedSingleBattleResult(slot0)
	uv0.UpdateRedPoint()
end)
manager.net:Bind(54111, function (slot0)
	if not ActivityData:GetActivityData(PushSnowBallData:GetActivityID()) or slot1.stopTime <= manager.time:GetServerTime() or manager.time:GetServerTime() < slot1.startTime then
		return
	end

	PushSnowBallData:OnReceviedTeamBattleResult(slot0)
	uv0.UpdateRedPoint()
end)
manager.net:Bind(78009, function (slot0)
	PushSnowBallData:OnUnlockDevice(slot0)
	uv0.UpdateDeviceRedPoint()
end)
manager.net:Bind(78013, function (slot0, slot1)
	uv0.CancleMatchingResultHandler(slot0, slot1)
end)
manager.net:Bind(78015, function (slot0)
	PushSnowBallData:SetPlayerList(slot0)
	BattleController:LaunchCooperationBattleWithoutRoom(slot0)
end)

return {
	SendEquipDevice = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(78002, {
			activity_id = slot1,
			equip = slot2
		}, 78003, uv0.EquipDeviceResultHandler)
	end,
	EquipDeviceResultHandler = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PushSnowBallData:SetSelectedDeviceID(slot1.equip)
		else
			ShowTips(GetTips(slot0.result))
		end

		manager.notify:Invoke(PUSH_SNOWBALL_EQUIP_DEVICE)
	end,
	SendStartMatching = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(78010, {
			dest = slot0,
			battle_type = slot1,
			hero_id = slot2,
			activity_id = slot3
		}, 78011, uv0.StartMatchingResultHandler)
	end,
	StartMatchingResultHandler = function (slot0, slot1)
		if isSuccess(slot0.result) then
			JumpTools.OpenPageByJump("pushSnowBallMatchPop")
		elseif slot0.result == 2 then
			ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_PUSH_ONLINE_DESC"), manager.time:GetLostTimeStr(slot0.timestamp, nil, true)))
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SendCancelMatching = function ()
		manager.net:Push(78012, {})
	end,
	CancleMatchingResultHandler = function (slot0, slot1)
		manager.notify.Invoke(PUSH_SNOWBALL_CANCLE_MATCHING)

		if not isSuccess(slot0.result) then
			ShowTips(GetTips(slot0.result))
		end
	end,
	ReceiveScoreReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = {
				slot1
			}
		}, 60055, handler(slot0, slot0.OnReceiveScoreReward))
	end,
	OnReceiveScoreReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			PushSnowBallData:ReceiveScoreReward(slot2.point_reward_id_list[1])
			getReward2(slot1.reward_list)
		else
			ShowTips(slot1.result)
		end

		manager.notify:CallUpdateFunc(PUSH_SNOW_BALL_REWAERD_SCORE_TASK)
		uv0.UpdateRedPoint()
	end,
	SendQuitBattle = function (slot0)
		manager.net:SendWithLoadingNew(78016, {
			battle_id = BattleFieldData:GetServerBattleID()
		}, 78017, function ()
		end)
	end,
	InitRedPoint = function ()
		slot0 = ActivityTools.GetRedPointKey(PushSnowBallData:GetActivityID()) .. PushSnowBallData:GetActivityID()
		slot1 = string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID())
		slot5 = PushSnowBallData
		slot6 = slot5
		slot2 = string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), slot5.GetTeamActivityID(slot6))

		for slot6 = 1, 3 do
			manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK, {
				RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. slot6
			})
			manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE, {
				RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. slot6
			})
			manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK, {
				RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. slot6
			})
		end

		if PushSnowBallData:GetTeamWinTaskList() then
			for slot7, slot8 in pairs(slot3) do
				manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN, {
					RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. slot8.id
				})
			end
		end

		manager.redPoint:addGroup(slot1, {
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD,
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE,
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK
		})
		manager.redPoint:addGroup(slot2, {
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN,
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE
		})
		manager.redPoint:addGroup(slot0, {
			slot1,
			slot2
		})
		uv0.UpdateRedPoint()
	end,
	IsActivityTime = function ()
		if not PushSnowBallData:GetActivityID() then
			return
		end

		slot0 = ActivityData:GetActivityData(PushSnowBallData:GetActivityID())

		if manager.time:GetServerTime() < slot0.stopTime and slot0.startTime < manager.time:GetServerTime() then
			return true
		end

		return false
	end,
	UpdateRedPoint = function ()
		slot0 = {}

		if uv0.IsActivityTime() then
			slot0 = PushSnowBallData:GetTeamWinTaskList()
		end

		for slot4 = 1, 3 do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. slot4, PushSnowBallData:GetHasCompeletedScoreTaskByModel(slot4) and 1 or 0)
		end

		for slot4 = 1, 3 do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. slot4, PushSnowBallData:GetIsNewLevelUnLock(slot4) and not (getData("PushSnowBall", "Level" .. slot4 .. PlayerData:GetPlayerInfo().userID) or false) and 1 or 0)
		end

		if slot0 then
			for slot4, slot5 in pairs(slot0) do
				manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. slot5.id, PushSnowBallData:GetHasCompeletedWinTaskByID(slot5.id) and 1 or 0)
			end
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD, PushSnowBallData:GetHasCompeletedWeeklyTask() and 1 or 0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE, PushSnowBallData:GetHasCompeletedTeamTask() and 1 or 0)
		uv0.UpdateDeviceRedPoint()
	end,
	UpdateDeviceRedPoint = function ()
		for slot3 = 1, 3 do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. slot3, PushSnowBallData:GetIsDeviceUnlockByID(slot3) and not getData("PushSnowBall", "Device" .. slot3 .. PushSnowBallData:GetActivityID() .. PlayerData:GetPlayerInfo().userID) and 1 or 0)
		end
	end
}
