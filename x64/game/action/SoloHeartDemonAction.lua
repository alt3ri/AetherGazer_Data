slot1 = nil

manager.net:Bind(75001, function (slot0)
	SoloHeartDemonData:InitSoloHeartDemonData(slot0)

	uv0 = slot0.open_edition

	uv1.InitRedPointKey(slot0.open_edition)
	uv1.UpdateRewardRedPoint()
	uv1.UpdateRefreshRedPoint(slot0)
	manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_UPDATE)
end)
manager.net:Bind(75005, function (slot0)
	SoloHeartDemonData:UpdateBattleFinishScore(slot0.score)
	manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_SCORE_UPDATE)
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateRefreshRedPoint({
		challenge_stage = SoloHeartDemonData:GetDataByPara("challengeStage")
	})

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
		return
	end

	if uv1 == nil then
		return
	end

	if getData("SOLO_HEART_DEMON", "ENTER_VIEW" .. uv1) ~= "1" then
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(uv1), uv1), 1)
	end
end)
manager.notify:RegistListener(ACTIVITY_TIMER_UPDATE, function (slot0)
	if uv0 == slot0 then
		manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_UPDATE)
	end
end)

return {
	GetReward = function (slot0)
		manager.net:SendWithLoadingNew(75002, slot0, 75003, uv0.OnGetRewardCallback)
	end,
	OnGetRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SoloHeartDemonData:UpdateRewardList(slot1)
			uv0.UpdateRewardRedPoint()
			getReward2(mergeReward2(slot0.reward_list))
			manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_REWARD_UPDATE, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	InitRedPointKey = function (slot0)
		uv0 = slot0

		manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(uv0), uv0), {
			RedPointConst.SOLO_HEART_DEMON_REWARD
		})

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			return
		end

		if getData("SOLO_HEART_DEMON", "ENTER_VIEW" .. uv0) ~= "1" then
			manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(uv0), uv0), 1)
		end
	end,
	UpdateRefreshRedPoint = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			return
		end

		if uv0 == nil then
			return
		end

		slot1 = getData("SOLO_HEART_DEMON", "STAGE")

		saveData("SOLO_HEART_DEMON", "STAGE", tostring(slot0.challenge_stage))

		if getData("SOLO_HEART_DEMON", "STAGE_VIEW") ~= "1" and slot3 == 0 then
			manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW, 1)

			return
		end

		if slot3 == 0 and slot1 ~= "0" then
			manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW, 1)
			manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(uv0), uv0), 1)
			saveData("SOLO_HEART_DEMON", "STAGE_VIEW", "0")
			saveData("SOLO_HEART_DEMON", "ENTER_VIEW" .. uv0, "0")
		end
	end,
	UpdateViewRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			return
		end

		saveData("SOLO_HEART_DEMON", "STAGE_VIEW", "1")
		manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW, 0)
	end,
	UpdateEnterRedPoint = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			return
		end

		if uv0 == nil then
			return
		end

		saveData("SOLO_HEART_DEMON", "ENTER_VIEW" .. uv0, "1")
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(uv0), uv0), 0)
	end,
	UpdateRewardRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			return
		end

		slot5 = RedPointConst.SOLO_HEART_DEMON_REWARD
		slot6 = 0

		manager.redPoint:setTip(slot5, slot6)

		for slot5, slot6 in pairs(SoloHeartDemonData:GetDataByPara("taskData")) do
			if SoloHeartDemonData:GetDataByPara("rewardList")[slot5] ~= 1 and slot6[2] <= slot6[1] then
				manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_REWARD, 1)
			end
		end
	end
}
