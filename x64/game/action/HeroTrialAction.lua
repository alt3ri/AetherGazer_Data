local var_0_0 = {}

manager.net:Bind(11035, function(arg_1_0)
	HeroTrialData:InitData(arg_1_0)
	manager.notify:Invoke(HERO_TRIAL_UPDATE)
end)

function var_0_0.GetTrialReward(arg_2_0, arg_2_1)
	manager.net:SendWithLoadingNew(11036, {
		id = arg_2_0
	}, 11037, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			HeroTrialData:ReceiveReward(arg_2_0)
		end

		arg_2_1(arg_3_0)
	end)
end

return var_0_0
