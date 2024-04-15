local var_0_0 = class("SectionSelectHeroIndiaNianView", SectionSelectHeroBaseView)

function var_0_0.OnEnter(arg_1_0)
	if IndiaNianCfg[arg_1_0.params_.destID].stage_type == 0 then
		arg_1_0:AddHpTimer()
	end

	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/indiaNianMain")
	end)
	arg_1_0.super.OnEnter(arg_1_0)
end

function var_0_0.AddHpTimer(arg_3_0)
	arg_3_0.timer_ = Timer.New(function()
		if IndiaNianData:GetCurrentHpByID(arg_3_0.params_.destID) == 0 then
			arg_3_0:Back()
		end
	end, 1, -1, true)

	arg_3_0.timer_:Start()
end

function var_0_0.OnExit(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end

	var_0_0.super.OnExit(arg_5_0)
end

return var_0_0
