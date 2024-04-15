local var_0_0 = {}

manager.net:Bind(75009, function(arg_1_0)
	CoreVerificationData:UpdateCycleInfo(arg_1_0)
	var_0_0.UpdateRewardRedPoints()
	var_0_0.UpdateChallengeRedPoints()
	manager.notify:Invoke(CORE_VERIFICATION_CYCLE_UPDATE)
end)

function var_0_0.GetReward(arg_2_0)
	manager.net:SendWithLoadingNew(75006, arg_2_0, 75007, var_0_0.OnGetRewardCallback)
end

function var_0_0.OnGetRewardCallback(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		CoreVerificationData:UpdateRewardData(arg_3_1)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(arg_3_0.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_GET_REWARD)
	else
		ShowTips(arg_3_0.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	local var_4_0 = {
		0,
		0,
		0,
		0
	}

	for iter_4_0 = 1, 4 do
		local var_4_1 = CoreVerificationData:GetRewardListByType(iter_4_0)

		for iter_4_1, iter_4_2 in ipairs(var_4_1) do
			local var_4_2, var_4_3, var_4_4, var_4_5 = CoreVerificationData:GetTaskProcess(iter_4_2)

			if var_4_4 and not var_4_5 then
				var_4_0[CoreVerificationRewardCfg[iter_4_2].reward_type] = 1
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD1, var_4_0[1])
	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD2, var_4_0[2])
	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD3, var_4_0[3])
	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD4, var_4_0[4])
end

function var_0_0.UpdateChallengeRedPoints()
	local var_5_0 = CoreVerificationData:IsStageProcess()
	local var_5_1 = getData("CoreVerification", "click_time") or 0
	local var_5_2 = _G.gameTimer:GetNextDayFreshTime()

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CORE_VERIFICATION) then
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 0)
	elseif var_5_0 or var_5_2 > 0 and var_5_2 <= var_5_1 then
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 0)
	else
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 1)
	end
end

return var_0_0
