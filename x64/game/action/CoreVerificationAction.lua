manager.net:Bind(75009, function (slot0)
	CoreVerificationData:UpdateCycleInfo(slot0)
	uv0.UpdateRewardRedPoints()
	uv0.UpdateChallengeRedPoints()
	manager.notify:Invoke(CORE_VERIFICATION_CYCLE_UPDATE)
end)

return {
	GetReward = function (slot0)
		manager.net:SendWithLoadingNew(75006, slot0, 75007, uv0.OnGetRewardCallback)
	end,
	OnGetRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CoreVerificationData:UpdateRewardData(slot1)
			uv0.UpdateRewardRedPoints()
			getReward(mergeReward(slot0.reward_list))
			manager.notify:CallUpdateFunc(CORE_VERIFICATION_GET_REWARD)
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateRewardRedPoints = function ()
		slot0 = {
			0,
			0,
			0,
			0
		}

		for slot4 = 1, 4 do
			for slot9, slot10 in ipairs(CoreVerificationData:GetRewardListByType(slot4)) do
				slot11, slot12, slot13, slot14 = CoreVerificationData:GetTaskProcess(slot10)

				if slot13 and not slot14 then
					slot0[CoreVerificationRewardCfg[slot10].reward_type] = 1
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD1, slot0[1])
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD2, slot0[2])
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD3, slot0[3])
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD4, slot0[4])
	end,
	UpdateChallengeRedPoints = function ()
		slot0 = CoreVerificationData:IsStageProcess()
		slot1 = getData("CoreVerification", "click_time") or 0
		slot2 = _G.gameTimer:GetNextDayFreshTime()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CORE_VERIFICATION) then
			manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 0)
		elseif slot0 or slot2 > 0 and slot2 <= slot1 then
			manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 0)
		else
			manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 1)
		end
	end
}
