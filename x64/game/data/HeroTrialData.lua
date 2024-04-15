local var_0_0 = singletonClass("HeroTrialData")

function var_0_0.Init(arg_1_0)
	arg_1_0.heroTrialStateList_ = {}
	arg_1_0.selectActivityHeroIDList_ = {}
	arg_1_0.stageIDToHeroTrialID_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_info) do
		arg_2_0.heroTrialStateList_[iter_2_1.id] = iter_2_1.challenge_state

		local var_2_0 = ActivityHeroTrialCfg[iter_2_1.id]

		if iter_2_1.challenge_state <= 1 then
			if ActivityData:GetActivityIsOpen(var_2_0.activity_id) then
				manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, var_2_0.activity_id, var_2_0.id), 1)
			end
		elseif iter_2_1.challenge_state > 1 then
			manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, var_2_0.activity_id, var_2_0.id), 0)
		end
	end
end

function var_0_0.RefreshRedData(arg_3_0)
	if not arg_3_0.heroTrialStateList_ then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.heroTrialStateList_) do
		if iter_3_0 and iter_3_0 ~= 0 then
			local var_3_0 = ActivityHeroTrialCfg[iter_3_0]
			local var_3_1 = false

			if not iter_3_1 then
				var_3_1 = true
			end

			if not ActivityData:GetActivityIsOpen(var_3_0.activity_id) then
				var_3_1 = true
			end

			if var_3_1 then
				manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, var_3_0.activity_id, var_3_0.id), 0)
			end
		end
	end
end

function var_0_0.ReceiveReward(arg_4_0, arg_4_1)
	arg_4_0.heroTrialStateList_[arg_4_1] = 2

	local var_4_0 = ActivityHeroTrialCfg[arg_4_1]

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, var_4_0.activity_id, var_4_0.id), 0)
end

function var_0_0.GetHeroTrialStateList(arg_5_0)
	return arg_5_0.heroTrialStateList_
end

function var_0_0.SetSelectActivityHeroID(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.selectActivityHeroIDList_[arg_6_1] = arg_6_2

	if arg_6_0.heroTrialStateList_[arg_6_2] ~= 1 then
		local var_6_0 = ActivityHeroTrialCfg[arg_6_2]

		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, var_6_0.activity_id, var_6_0.id), 0)
	end

	saveData("HeroTrial", "activityID_" .. tostring(arg_6_1), arg_6_2)
end

function var_0_0.GetSelectActivityHeroID(arg_7_0, arg_7_1)
	if arg_7_0.selectActivityHeroIDList_[arg_7_1] == nil then
		arg_7_0.selectActivityHeroIDList_[arg_7_1] = getData("HeroTrial", "activityID_" .. tostring(arg_7_1))
	end

	return arg_7_0.selectActivityHeroIDList_[arg_7_1]
end

function var_0_0.SaveStageID(arg_8_0, arg_8_1)
	local var_8_0 = ActivityHeroTrialCfg[arg_8_1].stage_id

	arg_8_0.stageIDToHeroTrialID_[var_8_0] = arg_8_1
end

function var_0_0.GetHeroTrialID(arg_9_0, arg_9_1)
	return arg_9_0.stageIDToHeroTrialID_[arg_9_1]
end

return var_0_0
