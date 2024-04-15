return {
	UpdataLogInRedPoint = function (slot0)
		for slot5, slot6 in ipairs(SPHeroChallengeTools:GetOpenActivityID()) do
			slot0:UpdataCanGetEntrustRewardRedPoint(slot6)
			slot0:UpdataCanGetChallengeRewardRedPoint(slot6)
		end
	end,
	UpdataCanGetEntrustRewardRedPoint = function (slot0, slot1)
		if SPHeroChallengeTools:CheckActivityIsOpen(slot1) and SPHeroChallengeData:GetActivityData(slot1) then
			if next(slot2:GetCanGetRewardEntrustIndexList()) then
				manager.redPoint:setTip(RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST, 1)
			else
				manager.redPoint:setTip(RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST, 0)
			end
		end
	end,
	UpdataCanGetChallengeRewardRedPoint = function (slot0, slot1)
		if SPHeroChallengeTools:CheckActivityIsOpen(slot1) and SPHeroChallengeData:GetActivityData(slot1) then
			if slot2:CheckCanGetHeroChipTaskAward() then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot1), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot1), 0)
			end
		end
	end
}
